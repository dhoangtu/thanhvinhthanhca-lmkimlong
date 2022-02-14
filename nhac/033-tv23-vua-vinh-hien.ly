% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Vua Vinh Hiển" }
  composer = "Tv. 23"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 c8 |
  \repeat volta 2 {
    e8. f16 e8 e |
    g2 |
    c8. b16 a8 a |
    r8 c16 c b8 c |
    d d16 d c8 d |
    e4. c8 |
    d d a16 (c) a8 |
    g2 ~ |
    g4 g8 g |
    f8. d16 d8 g |
    c,4 r8 g' |
    e'8. e16 c8 d |
    d4 r8 d
  }
  \alternative {
    {
      c8. c16 b8 c |
      d g, ~ g4 ~ |
      g r8 c,
    }
    {
      g'8. g16 d'8 c |
      b \stemDown c ~ c4 ~ |
      c4 r8 \bar "||" \break
    }
  }
  
  c8 |
  c c16 g f8 g |
  e4 r8 d |
  d d16 a' fs8 g |
  g a4 ^> b8 |
  c b4 ^> c8 |
  d4 r8 c |
  c c16 e d8 b |
  c4 r8 a |
  b b16 c b8 a |
  g a4 ^> f8 |
  e f4 ^> d8 |
  c4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  c8 |
  e8. f16 e8 e |
  g2 |
  e8. g16 f8 f |
  r e16 e d8 e |
  g8 g16 g e8 g |
  c4. a8 |
  g g fs [fs] |
  g2 ~ |
  g4 g8 g |
  f8. d16 d8 g |
  c,4 r8 g' |
  c8. c16 a8 a |
  g4 r8 f |
  e8. e16 g8 a |
  f e ~ e4 ~ |
  e r8 c |
  e8. e16 d8 f |
  g <e c> ~ <e c>4 ~ |
  <e c>4 r8
  
  c'8 |
  c c16 g f8 g |
  e4 r8 d |
  d d16 a' fs8 g |
  g fs4 g8 |
  a g4 ^> a8 |
  b4 r8 c |
  c c16 e d8 b |
  c4 r8 a |
  b b16 c b8 a |
  g f4 d8 |
  c d4 ^> b8 |
  c4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Cửa ơi, hãy ngẩng đầu lên,
  hỡi cửa ngàn đời,
  Mau vươn mình lên nữa,
  mau vươn mình lên nữa
  để Vua vinh hiển ngự vào.
  Vua vinh hiển Người là ai vậy?
  
  <<
    {
      Là Chúa lẫm liệt oai phong,
      Đức
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    Thượng Đế lãnh đạo thiên binh, chính
	  }
  >>
  Vua uy hùng khi xuất trận,
  Cửa
  
  Người là Đức Vua hiển vinh.
  <<
    {
      \set stanza = "1."
      Trái đất với muôn vật muôn loài,
      Hoàn cầu cùng tất cả cư dân là của Chúa,
      là của Chúa,
      Ngài đặt nền đất trên biển khơi,
      làm cho kiên vững không chuyển rời giữa sông ngòi,
      giữa sông ngòi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Núi thánh Chúa, ai người lên được?
	    Đền vàng Ngài, kẻ nào nương thân thực vinh phúc,
	    thực vinh phúc,
	    là người hằng giữ tay sạch tinh,
	    miệng không gian dối nên luôn được Chúa thương tình,
	    Chúa thương tình.
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
    \override Lyrics.LyricSpace.minimum-distance = #0.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
