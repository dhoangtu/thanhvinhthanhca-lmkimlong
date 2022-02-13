% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Toàn Cầu Tung Hô Chúa" }
  composer = "Tv. 99"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4 c8c |
  a'8. f16 bf8 b! |
  c2 ~ |
  c8 c a f |
  g8. g16 d8 c |
  c4 c8 c |
  a'8. a16 f8 f |
  bf2 ~ |
  bf8 bf g e |
  d8. c16 g'8 g |
  f2 \bar "||"
  
  e8. e16 a8 d, |
  g g4 g8 |
  f8. a16 g (f) c8 |
  d4 r8 d |
  g g f f16 f |
  bf8 c c, e16 (g) |
  f2 ~ |
  f4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  c8 c |
  f8. d16 g8 f |
  e2 ~ |
  e8 e f d |
  c8. c16 b!8 c |
  c4 c8 c |
  f8. f16 ef8 ef |
  d2 ~ |
  d8 d d c |
  bf8. a16 bf8 c |
  a2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Toàn cầu hỡi, nào tung hô Chúa,
  Với bao mừng vui tới tôn thờ Ngài,
  Vào bệ kiến cất lời hò reo.
  Hãy tin nhận Ngài là Chúa chúng ta.
  <<
    {
      \set stanza = "1."
      Vì Ngài đã dựng nên ta,
      ta thuộc (i -- a) về Ngài,
      là con dân Ngài,
      là đoàn chiên chính Ngài dẫn đưa.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Nào cùng tiến vào khuôn viên
	    dâng lời (i -- a) cảm tạ,
	    vào nơi cung điện
	    hòa lời ca tán tụng Thánh Danh.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Vì Ngài tốt lành vô biên,
	    không hề (i -- a) chuyển rời,
	    tình yêu thương Ngài
	    ngàn đời luôn tính thành chẳng ngơi.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2.5))
}

TongNhip = {
  \key f \major \time 2/4
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
