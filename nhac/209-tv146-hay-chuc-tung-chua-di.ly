% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Hãy Chúc Tụng Chúa Đi" }
  composer = "Tv. 146"
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
  a4 \tuplet 3/2 { a8 f a } |
  g4 \tuplet 3/2 { bf8 g g } |
  a4. e8 |
  e f4 g8 |
  c,4 \tuplet 3/2 { d8 c a' } |
  a4. f8 |
  bf g4 bf8 |
  bf4 r8 c, |
  g'4 \tuplet 3/2 { g8 e g } |
  f2 \bar "||"
  
  f4. e16 d |
  d4 \tuplet 3/2 { g8 g g } |
  g4 r8 bf16 a |
  a4. f8 |
  e4 \tuplet 3/2 { e8 g e } |
  d4 r8 d16 e |
  c4. d8 |
  f4 \tuplet 3/2 { e8 e g } |
  a4. bf16 bf |
  g4. c,8 |
  g' a4 g8 |
  f2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  f4 \tuplet 3/2 { f8 d f } |
  c4 \tuplet 3/2 { g'8 e e } |
  f4. c8 |
  cs d4 b!8 |
  c4 \tuplet 3/2 { bf8 a c } |
  f4. d8 |
  g e4 d8 |
  e4 r8 c |
  bf4 \tuplet 3/2 { c8 c bf } |
  a2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \stanzaReminderOff
  \set stanza = "ĐK:"
  Hãy chúc tụng Chúa đi,
  thú vị dường bao được đàn ca kính Ngài.
  Thỏa tình biết mấy được tán tụng danh Chúa.
  Nào hãy chúc tụng Chúa đi.
  \stanzaReminderOn
  <<
    {
      \set stanza = "1."
      Chúa xây dựng lại Giê -- ru -- sa -- lem,
      Ít -- ra -- en tản lạc Ngài quy tụ về.
      Bao cõi lòng tan vỡ Ngài đà thuyên chữa,
      những vết thương Ngài băng bó cho lành.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chúa nay ngự duyệt tinh sao trên không,
	    xướng danh lên để gọi từng ngôi riêng biệt.
	    Ôi Chúa thực cao sáng, quyền lực vô đối,
	    trí thông minh thực tinh suốt khôn lường.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Chúa nâng người nghèo lên nơi cao sang,
	    Lũ gian mạnh nhận chìm tận đất đen rồi.
	    Cung sắt cầm dạo lên tụng mừng Thiên Chúa,
	    hãy xướng ca mà cảm mến ơn Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chúa che bầu trời cho mây giăng giăng,
	    Khiến mưa sa gội nhuần toàn cõi địa cầu.
	    Cho núi đồi tươi thắm, đẹp mầu hoa lá,
	    sẵn rau ngon để nhân thế hưởng dùng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Chúa không trọng vọng đội chân lanh chai,
	    Vó câu phi vội vàng Ngài chẳng ưa gì.
	    Nhưng mến chuộng ai vẫn trọn niềm tin kính,
	    vững trông nơi tình thương mến của Ngài.
    }
  >>
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
  page-count = #1
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
    \override Lyrics.LyricSpace.minimum-distance = #0.6
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
