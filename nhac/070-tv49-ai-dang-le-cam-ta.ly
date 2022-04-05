% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Ai Dâng Lễ Cảm Tạ" }
  composer = "Tv. 49"
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
nhacPhienKhucSop = \relative c' {
  \partial 4. c8 f f |
  d8. c16 a8 bf |
  \slashedGrace { d16 ( } c2) ~ |
  c8 c c g' |
  g8. bf16 a8 g |
  f2 ~ |
  f4 r8 f |
  f8. f16 bf8 c |
  d2 ~ |
  d8 c16 ([f]) d8 c |
  a bf4 c8 |
  g ([bf a]) g |
  f2 \bar "||" \break
  
  f8. f16 g8 d |
  c4. a'8 |
  f4 bf8 a |
  g2 |
  c8. c16 c8 d |
  a4. a8 |
  a8. bf16 g8 c |
  f,2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r4. |
  R2*12
  
  f8. f16 g8 d |
  c4. f8 |
  d4 g8 f |
  e2 |
  a8. a16 a8 g |
  f4. f8 |
  f8. g16 e8 e |
  f2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Thượng Đế chí tôn nay Ngài lên tiếng
      Triệu tập chư dân khắp cõi địa cầu.
      Người đòi trời cao đất thấp phải ra phiên tòa
      nghe Chúa xử dân Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Này hãy lắng nghe bao lời Ta phán
	    Vì thực Ta đây Chúa ngươi tôn thờ.
	    Cần gì đòi ngươi tế lễ
	    bởi Ta đâu thèm chi máu thịt chiên bò.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Hãy kính tiến lên bao lời cảm mến
	    Trọn niềm tri ân Chúa muôn cao trọng
	    Vào hồi gặp cơn nguy khốn,
	    Hãy kêu xin là Ta tế độ an toàn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Miệng nhắc nhớ luôn bao điều giao ước
	    Mà lòng khinh chê giới răn Ta truyền,
	    Vừa gặp phường gian trộm cướp
	    Ấy ngươi vội vàng theo chúng để chia phần.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Còn tấc lưỡi luôn thêu dệt xảo trá
	    Ngồi là lê la diễu bêu lân bàng,
	    Từng tội rầy Ta khiển trách
	    Hỡi quân gian tà mau gắng hiểu cho tường.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Này hỡi những ai quên lời Thượng Đế
	    Lẳng lặng nghe đây, gắng suy cho tường,
	    Kẻo rồi bị Ta xé xác,
	    Chẳng trông mong còn ai cứu nổi cho cùng.
    }
  >>
  \stanzaReminderOff
  \set stanza = "ĐK:"
  Ai dâng lễ cảm tạ sẽ làm hiển danh Ta,
  Ai đi trong chính lộ Ta cho thấy ơn cứu độ.
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
  page-count = 1
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2))
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
    \override Lyrics.LyricSpace.minimum-distance = #1
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
