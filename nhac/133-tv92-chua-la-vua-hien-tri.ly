% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Chúa Là Vua Hiển Trị" }
  composer = "Tv. 92"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  c8 f, g16 (f) c8 |
  d4. d8 |
  g g f16 (g) f8 |
  e4 r8 a |
  a16 (g) f8 f bf |
  bf4 r8 c |
  bf8. c16 d8 g, |
  bf c4 g8 |
  g8 c bf g |
  f4 r8 \bar "||"
  
  c8 |
  a'4. a8 |
  f g4 f8 |
  d4 r8 d |
  c8 c r c |
  a'4. f8 |
  bf g4 c8 |
  e,4. c8 |
  g' g4 g8 |
  f2 ~ |
  f4 r \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  R2*9
  r4.
  c8 |
  f4. f8 |
  d c4 d8 |
  bf4 r8 bf |
  a a r c |
  f4. d8 |
  g e4 d8 |
  c4. a8 |
  bf c4 c8 |
  a2 ~ |
  a4 r
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Chúa là vua hiển trị
      Mặc oai phong tựa cẩm bào,
      Lấy dũng lực làm cân đai,
      Ngai vàng kiên cố tự ngàn xưa,
      Ngài hiện hữu tự muôn đời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Chúa dựng nên địa cầu
	    Trải bao năm chẳng chuyển rời,
	    Sóng nước đà gầm vang lên,
	    Cho dù sóng nước gầm vang lên,
	    Dập dồn đất lở, long trời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Át hẳn tiếng ngàn trùng,
	    vượt trên sóng biển oai hùng,
	    Chúa hiển trị thực uy phong,
	    Hiển trị trên cõi trời cao xanh,
	    Hiển trị đến muôn muôn đời.
    }
  >>
  \set stanza = "ĐK:"
  Lời Chúa vững bền đáng tin cậy,
  Nơi đền vàng, lạy Chúa,
  rực lên toàn thánh thiện triền miên qua bao đời.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2))
  page-count = 1
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
