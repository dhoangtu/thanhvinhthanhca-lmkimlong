% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Xin Dâng Lời Suy Tôn" }
  composer = "Đn. 3,52-57"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4 e8 c |
  f4. d16 g |
  a8 g16 (a) c8 d |
  e4 r8 d16 d |
  b8 c c a |
  g2 ~ |
  g4 \bar "||" \break
  
  g8 e |
  a4. e16 e |
  f8 d d16 (e) a8 |
  g4 r8 c16 c |
  a8 d d d |
  c2 ~ |
  c4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r4 |
  R2*2
  r4 r8 f16 fs |
  g8 a a f |
  e2 ~ |
  e4
  r4 |
  R2*2
  g4 r8 e16 e |
  f8 f g g |
  e2 ~ |
  e4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Ca tụng Chúa là Thiên Chúa tổ tiên chúng con,
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ca tụng Chúa từ trong thánh điện ngợp ánh quang,
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Ca tụng Chúa, Ngài soi thấu lòng vực thẳm sâu,
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ca tụng Chúa ngự trên các vòm trời ngất cao,
    }
  >>
  \override Lyrics.LyricText.font-series = #'bold
  Xin dâng lời suy tôn muôn đời.
  \revert Lyrics.LyricText.font-series
  
  <<
    {
      \set stanza = "1."
      Ca tụng Chúa, ôi danh thánh Ngài thật hiển vinh.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ca tụng Chúa trên ngai báu của vị quốc vương,
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Ca tụng Chúa trên muôn sứ thần hộ giá đây,
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ca tụng Chúa ngay nơi các vật Ngài tác sinh,
    }
  >>
  \override Lyrics.LyricText.font-series = #'bold
  Xin dâng lời suy tôn muôn đời.
  \revert Lyrics.LyricText.font-series
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 3))
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
