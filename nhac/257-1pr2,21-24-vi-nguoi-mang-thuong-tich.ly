% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Vì Người Mang Thương Tích" }
  composer = "1Pr. 2,21-24"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  bf4. a8 |
  a4 r8 f |
  g ef4 d8 |
  g2 |
  bf8. bf16 bf8 c |
  d4. c8 |
  c d d bf |
  a2 |
  d,8 d g a |
  bf4. a8 |
  c c bf16 (a) d8 |
  g,4 r8 \bar "|." \break
  
  d16 d |
  ef8 d g a |
  fs8 fs r8 d16 g |
  bf8 g g16 (bf) c8 |
  c2 |
  c8. bf16 bf8 c16 (d) |
  d4. a8 |
  bf8. d,16 bf'8 a |
  g2 \bar "||"
}

nhacPhienKhucAlto = \relative c'' {
  g4. c,8 |
  d4 r8 d |
  ef c4 c8 |
  bf2 |
  g'8. g16 g8 a |
  bf4. a8 |
  a bf bf g |
  d2 |
  d8 c bf d |
  g4. d8 |
  a' a g [fs] |
  g4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Đức Ki -- tô chịu đau khổ vì ta,
  Để lại một gương mẫu cho ta dõi bước theo Người.
  Vì Người mang thương tích mà ta nay được chữa lành.
  <<
    {
      \set stanza = "1."
      Thật Người chẳng hề vương vấn tội tình,
      Nào ai thấy được ở trên môi cho dù một tiếng nói
      nhiễm vương tỳ vết gian tà.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Bị nguyền rủa Người không rủa nguyền lại,
	    Chịu đau đớn mà chẳng đe lời,
	    Nhưng một bề phó thác cho Đấng xử xét công bình.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Tội tình ta Người mang hết vào mình,
	    Rồi đem lên thập tự hy sinh.
	    Khi vì tội đã chết, ta hãy lại sống ngay lành.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 3))
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
