% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Xin Thương Con" }
  composer = "Tv. 56"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4 \tuplet 3/2 { g8 g g } |
  e4. e8 |
  c'4 \tuplet 3/2 { b8 b b } |
  a4 r8 g16 c |
  b8 c e c |
  d2 ~ |
  d4 \tuplet 3/2 { d8 d d } |
  b4. b8 |
  c4 \tuplet 3/2 { c8 d c } |
  a4 r8 g16 a |
  f8 d b g' |
  g2 ~ |
  g4 \bar "||"
  
  <> \tweak extra-offset #'(-5.5 . -2.5) _\markup { \bold "ĐK:" }
  e'16 (f) e8 |
  d4 c8 c |
  a4. a16 (c) |
  g4 e8 e |
  a4 a8 g |
  c4. c8 |
  b2 |
  b8. b16 c8 d ~ |
  d a f' d |
  e2 |
  b8. d16 c8 [g] ~ |
  g e' d b |
  c2 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  r4 |
  R2*11
  r4
  
  c16 (d) c8 |
  g4 a8 a |
  f4. f8 |
  e4 c8 c |
  f4 f8 e |
  a4. a8 |
  g2 |
  g8. gs16 a8 f ~ |
  f f a b |
  c2 |
  g8. f16 f8 e ~ |
  e [c] f g e2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Xin thương con cùng lạy Chúa
      xin thương con cùng
      Vì bên Ngài con đến ẩn thân,
      Dưới bóng cánh Ngài
      giờ đây con đến nương mình
      Cho tới khi tai họa qua đi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Con kêu lên Ngài,
	    lạy Chúa cao quang muôn trùng
	    Từ cung trời ban xuống hồng ân,
	    Chúa hãy chiếu dọi tình thương,
	    chân lý của Ngài,
	    Mau cứu con khỏi phường vô luân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Ôi thân con này nằm giữa bao nhiêu quân thù
	    Tựa sư tử hung dữ vờn quanh,
	    Lưỡi chúng khác gì làn gươm loang bén vô ngần,
	    Nanh chúng như đao nhọn, tên bay.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Xin mau vươn mình, lạy Chúa trên muôn cung trời,
	    Hiển vinh Ngài dọi khắp trần gian,
	    Chúng mắc lưới dò hại con,
	    nay chúng rơi vào,
	    Khơi hố sâu để rồi sa chân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Con nay an lòng,
	    lạy Chúa con nay an lòng,
	    Dạo cung đàn con sẽ ngợi ca.
	    Thức giấc hỡi hồn,
	    dậy đi cung sắt cung cầm,
	    Tôi sẽ lay tỉnh bình minh đây.
    }
  >>
  %\set stanza = "ĐK:"
  \set stanza = ""
  Giữa muôn dân con dâng lời cảm tạ,
  Từ vạn quốc con đàn hát xướng ca.
  Vì tình thương Chúa vượt lút trời cao,
  Lòng tín trung Ngài vút trên ngàn mây.
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
}

TongNhip = {
  \key c \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
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
     (padding . 1)
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
                      (ly:pointer-group-interface::add-grob text
'side-support-elements syllable))
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
% kết thúc mã nguồn

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
