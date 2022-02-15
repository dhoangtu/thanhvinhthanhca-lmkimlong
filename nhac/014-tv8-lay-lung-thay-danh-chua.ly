% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Lẫy Lừng Thay Danh Chúa" }
  composer = "Tv. 8"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4 g8 g |
  c2 |
  e,8 a4 a8 |
  g2 |
  c8. c,16 d8 e |
  f4. d8 |
  g g4 b,8 |
  c4 g'8 g |
  a2 |
  g8 d'4 b8 |
  c2 \bar "||" \break
  
  c8 g f f |
  g8. f16 d8 f |
  g e4 d8 |
  c2 |
  c'8 a16 (g) f8 g |
  d f4 g8 |
  g2 ~ |
  g4 g8 <g \tweak font-size #-2 f>
  \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  g8 f |
  e2 |
  c8 f4 f8 |
  e2 |
  c'8. c,16 d8 e |
  f4. d8 |
  g g4 b,8 |
  c4 e8 e |
  f2 |
  e8 f4 g8 |
  e2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Vạn lạy Chúa là Chúa chúng con,
  Lẫy lừng thay danh Chúa trên khắp cõi địa cầu,
  Uy phong Chúa vượt quá trời cao.
  <<
    {
      \set stanza = "1."
      Chúa cho miệng trẻ thơ vang lời ngợi khen chống quân thù.
      Khiến quân thù, kẻ nghịch phải tiêu tan.
      Vạn lạy
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ngắm trông vòm trời cao với ngàn trăng sao Chúa an bài,
	    Thế nhân là chi mà Ngài quan tâm?
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Nếu so cùng thần minh con người chẳng kém thua chi nhiều,
	    Nắm vinh dự thống trị cả thiên nhiên.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Đó chiên bò cùng cá vẫy vùng biển khơi,
	    lũ chim trời, Chúa đem đặt tất cả ở chân ta.
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
    \override Lyrics.LyricSpace.minimum-distance = #2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
