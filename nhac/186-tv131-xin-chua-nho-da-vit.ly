% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Xin Chúa Nhớ Đa-vít" }
  composer = "Tv. 131"
  tagline = ##f
}

% mã nguồn cho những chức năng chưa hỗ trợ trong phiên bản lilypond hiện tại
% cung cấp bởi cộng đồng lilypond khi gửi email đến lilypond-user@gnu.org
% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

% in số phiên khúc trên mỗi dòng
#(define (add-grob-definition grob-name grob-entry)
     (set! all-grob-descriptions
           (cons ((@@ (lily) completize-grob-entry)
                  (cons grob-name grob-entry))
                 all-grob-descriptions)))

#(add-grob-definition
    'StanzaNumberSpanner
    `((direction . ,LEFT)
      (font-series . bold)
      (padding . 1.0)
      (side-axis . ,X)
      (stencil . ,ly:text-interface::print)
      (X-offset . ,ly:side-position-interface::x-aligned-side)
      (Y-extent . ,grob::always-Y-extent-from-stencil)
      (meta . ((class . Spanner)
               (interfaces . (font-interface
                              side-position-interface
                              stanza-number-interface
                              text-interface))))))

\layout {
    \context {
      \Global
      \grobdescriptions #all-grob-descriptions
    }
    \context {
      \Score
      \remove Stanza_number_align_engraver
      \consists
        #(lambda (context)
           (let ((texts '())
                 (syllables '()))
             (make-engraver
              (acknowledgers
               ((stanza-number-interface engraver grob source-engraver)
                  (set! texts (cons grob texts)))
               ((lyric-syllable-interface engraver grob source-engraver)
                  (set! syllables (cons grob syllables))))
              ((stop-translation-timestep engraver)
                 (for-each
                  (lambda (text)
                    (for-each
                     (lambda (syllable)
                       (ly:pointer-group-interface::add-grob
                        text
                        'side-support-elements
                        syllable))
                     syllables))
                  texts)
                 (set! syllables '())))))
    }
    \context {
      \Lyrics
      \remove Stanza_number_engraver
      \consists
        #(lambda (context)
           (let ((text #f)
                 (last-stanza #f))
             (make-engraver
              ((process-music engraver)
                 (let ((stanza (ly:context-property context 'stanza #f)))
                   (if (and stanza (not (equal? stanza last-stanza)))
                       (let ((column (ly:context-property context
'currentCommandColumn)))
                         (set! last-stanza stanza)
                         (if text
                             (ly:spanner-set-bound! text RIGHT column))
                         (set! text (ly:engraver-make-grob engraver
'StanzaNumberSpanner '()))
                         (ly:grob-set-property! text 'text stanza)
                         (ly:spanner-set-bound! text LEFT column)))))
              ((finalize engraver)
                 (if text
                     (let ((column (ly:context-property context
'currentCommandColumn)))
                       (ly:spanner-set-bound! text RIGHT column)))))))
      \override StanzaNumberSpanner.horizon-padding = 10000
    }
}

stanzaReminderOff =
  \temporary \override StanzaNumberSpanner.after-line-breaking =
     #(lambda (grob)
        ;; Can be replaced with (not (first-broken-spanner? grob)) in 2.23.
        (if (let ((siblings (ly:spanner-broken-into (ly:grob-original grob))))
              (and (pair? siblings)
                   (not (eq? grob (car siblings)))))
            (ly:grob-suicide! grob)))

stanzaReminderOn = \undo \stanzaReminderOff
% kết thúc mã nguồn

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  a8. bf16 bf8 g |
  a4. a16 g |
  e8 f g d |
  c4 r8 a16 c |
  f8 f e g |
  a4. a16 a |
  a8 f bf a |
  g4 r8 c |
  d4. bf16 g |
  g4 r8 \slashedGrace { f16 ( } g) d |
  c8 a16 (c) g'8 g |
  f4 r8 f16 e |
  d8 d g g |
  a4. g16 d |
  c8 e g e |
  f4 r8 \bar "||" \break
  
  a |
  a4. bf16 bf |
  bf8 a g c |
  f,4. f16 g |
  e8 d c c |
  a'4 r8 a16 a |
  bf8 g a bf |
  c4. bf16 d |
  g,8 d g e |
  f2 ~ |
  f4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  R2*15
  r4.
  f8 |
  f4. g16 g |
  g8 f e e |
  d4. d16 c |
  c8 b! c c |
  f4 r8 f16 f |
  g8 e f g |
  a4. g16 f |
  bf,8 bf bf c |
  a2 ~ |
  a4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Xin Chúa nhớ Đa -- vít với bao là công sức của người,
      Người thành tâm đoan thề lên Chúa,
      Đã khấn hứa cùng Đấng Uy linh:
      Tôi quyết chẳng về nhà,
      chẳng lên giường chợp mắt khép mi
      Trước khi tìm được nơi cho Chúa,
      Kiếm ra đền cho Đấng Toàn Năng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Nghe nói tới hòm bua lúc cư ngụ ở Ép -- ra -- tha,
	    Về đồng Gia -- a tìm cho thấy,
	    Tiến bước tới phục bái suy tôn,
	    Cung ính trước bệ rồng,
	    cúi xin Ngài vùng đứng,
	    Chưa ơi, Tiến lên cùng hòm bia giao ước,
	    Giáng ngự về nơi thánh nghỉ ngơi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Mong ước các tư tế sẽ luôn mặc công chính của Ngài,
	    Kẻ thành tâm reo hò vui sướng,
	    Chúa chớ hắt hủi đấng Ki -- tô,
	    Xưa Chúa đã thề nguyền, đến muôn đời chẳng có hối lui:
	    Hoa quả lòng dạ ngươi, Đa -- vít
	    Sẽ hiển trị ngôi báu của ngươi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Con cháu nếu trung tín giữ vuông tròn giao ước Ta truyền,
	    Và thực thi qui luật Ta phán:
	    Sẽ mãi mãi được kế ngôi ngươi.
	    Đây Chúa đã chọn lựa chốn yên nghỉ ở giữa Si -- on,
	    Chốn Ta chọn vì Ta ưa thích,
	    Đến muôn đời Ta sẽ nghỉ ngơi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Nơi đấy chính Ta sẽ khiến miêu duệ Đa -- vít kiêu hùng,
	    Ngọn đèn luôn luôn được châm sáng
	    Ấy chính đấng được Chúa phong vương,
	    Trong lúc bao địch thù phải phủ đầy nhục nhã thảm thê,
	    Chính trên đầu hoàng vương Ta đó
	    sẽ rạng ngời muôn ánh triều thiên.
    }
  >>
  \stanzaReminderOff
  \set stanza = "ĐK:"
  Nơi đây Chúa chúc phúc cho người chính trực,
  ban bánh ăn cho người nghèo khó,
  Cho tư tế mặc ơn công chính,
  kẻ tín thành mừng rỡ hò reo.
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  system-system-spacing = #'((basic-distance . 0.1) (padding . 3.5))
  page-count = 2
  ragged-bottom = ##t
}

TongNhip = {
  \key f \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
