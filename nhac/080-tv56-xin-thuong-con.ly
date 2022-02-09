% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Xin Thương Con" }
  composer = "Tv. 56"
  %arranger = "Lm. Kim Long"
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
  g4 \bar "||" \break
  
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
  \set stanza = "ĐK:"
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
  system-system-spacing = #'((basic-distance . 0.1)
                             (padding . 3))
  ragged-bottom = ##t
}

TongNhip = {
  \key c \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

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
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
