% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Chúa Đừng Làm Thinh Hoài" }
  composer = "Tv. 82"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 d8 |
  bf'4 \tuplet 3/2 { bf8 g g } |
  a4 \tuplet 3/2 { a8 fs fs } |
  g2 |
  d4 d8 d16 d |
  d8 bf' bf c |
  a4 g8 g16 g |
  g8 ef' ef ef |
  d4 r8 bf16 bf |
  c8 d bf c |
  a4 r8 d,16 d |
  a'8 a fs a |
  g2 \bar "||"
  
  f!?8. f16 g8 f |
  d4 \tuplet 3/2 { g8 fs g } |
  a2 |
  r8 c16 d d8 bf |
  g g16 fs g8 a |
  bf4 r8 c16 bf |
  c8 d bf g |
  a4 r8 g16 ef |
  d8 bf' a fs |
  g4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  d8 |
  g4 \tuplet 3/2 { g8 ef ef } |
  c4 \tuplet 3/2 { c8 d d } |
  ef4 (d8 c) |
  bf4 d8 d16 d |
  d8 d g a |
  fs4 g8 g16 g |
  g8 g a c |
  bf4 r8 g16 g |
  a8 bf g a |
  d,4 r8 d16 d |
  c8 c d c |
  bf2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Lạy Chúa, xin đừng làm thinh,
  chớ ngồi lặng yên hoài.
  Kìa địch thù Ngài xôn xao náo động,
  Và từng đoàn người ghét Chúa dấy lên.
  Họ bày mưu ám hại dân Ngài,
  và lập kế chống kẻ Chúa thương.
  <<
    {
      \set stanza = "1."
      Ôi Thiên Chúa con thờ xin làm cho chúng
      Như chiếc lá quay cuồng,
      như cọng rơm trước gió,
      như lửa thiêu cháy rụi rừng xanh,
      như hỏa hào ngốn tiêu đồi nương.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Cho giông tố lan tràn xua dẹp bọn chúng
	    trung bão táp rợn rùng cho họ thêm kinh hãi,
	    cho họ khi bẽ mặt hổ ngươi.
	    Biết trông tìm thánh danh Ngài đi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Xin cho chúng ô nhục, kinh hoàng luôn mãi
	    Cho chúng nếm thẹn thùng,
	    cho diệt vong muôn kiếp,
	    mau nhận ra khắp trên trần gian,
	    thánh danh Ngài tối cao lừng vang.
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
  \key bf \major \time 2/4
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
