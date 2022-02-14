% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Bên Sông Babylon" }
  composer = "Tv. 136"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 g8 |
  g4. g16 g |
  a4 r8 bf16 bf |
  a8 bf4 c8 |
  d4. d8 |
  bf (a) g a |
  a4 r8 g |
  fs g4 a8 |
  bf4 r8 bf |
  a bf4 c8 |
  d4. c8 |
  bf (a) d a |
  g4 r8 \bar "|."
  
  g16 g |
  fs4 \tuplet 3/2 { d8 a' a } |
  bf4 r8 bf16 bf |
  g4 \tuplet 3/2 { d8 g c } |
  c4 r8 ef16 d |
  d4. d16 c |
  c4. bf8 |
  bf d d, fs |
  g4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  g8 |
  g4. f16 ef |
  d4 r8 g16 g |
  fs8 g4 a8 |
  bf4. bf8 |
  g (f) c c |
  d4 r8 g |
  fs8 g4 a8 |
  bf4 r8 g |
  fs g4 a8 |
  bf4. a8 |
  g4 fs8 fs |
  g4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Bên sông Ba -- by -- lon ta ra ngồi
  mà than khóc nhớ tưởng về Si -- on.
  Trên cành cây dương liễu,
  trên cành cây dương liễu ta tạm gác cây đàn.
  <<
    {
      \set stanza = "1."
      Quân canh tù đòi ta ca xướng,
      Lũ cướp này giục gượng vui lên:
      Hát ta nghe, hát ta nghe một bài thánh nhạc Si -- on.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Nơi quê người làm sao ta hát,
	    Đất khách này đời nào ta ca những câu ca,
	    những câu ca tụng mừng Chúa Trời của ta.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Tay chơi đàn thành ra tê cứng,
	    Lưỡi dính chặt vào họng ta đi
	    Nếu ta thôi lấy Gia -- liêm làm tuyệt đích của tâm can.
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
    \override Lyrics.LyricSpace.minimum-distance = #2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
