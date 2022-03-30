% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Chúa Vẫn Trọn Tình Thương" }
  composer = "Tv. 135"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  c4. f,16 g |
  a4 \tuplet 3/2 { e8 g f } |
  c4 r8 \bar "||" \break
  a' |
  g d'16 d b!8 b |
  c2 \bar "||" \break
  
  bf4. g16 c |
  e,4 \tuplet 3/2 { c8 g' g } |
  g4 r8 \bar "||" \break
  g8 |
  f bf16 bf g8 g |
  a2 \bar "||" \break
  
  a4. e16 f |
  g4 \tuplet 3/2 { f8 bf a } |
  d,4 r8 \bar "||" \break
  d |
  c g'16 g e8 e |
  f2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  R2*2
  r4.
  f8 |
  e f16 f g8 g |
  e2 |
  R2*2
  r4.
  c8 |
  d g16 g e8 e |
  f2 |
  R2*2
  r4.
  bf,8 |
  a bf16 bf c8 c |
  a2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Hãy tạ ơn Chúa, vì Chúa nhân từ
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chúa làm nhên những việc rất phi thường
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Chúa tạo nên những đến lớn trên trời
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Giết sạch con trưởng toàn cõi Ai -- cập
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Chúa đà phân rẽ triều nước biển Hồng
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Dẫn đường dân Chúa ở giữa sa mạc
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Chiềm bờ cõi chúng và đã trao tặng
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "8."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chúa giật ta thoát khỏi lũ quân thù
    }
  >>
  \override Lyrics.LyricText.font-series = #'bold
  Muôn đời Chúa vẫn trọn tình thương
  \revert Lyrics.LyricText.font-series
  
  <<
    {
      \set stanza = "1."
      Hãy cảm mến Ngài là Chúa các Chúa
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chính Ngài tác tạo trời xanh bao la
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Vẫn điều khiển ngày là kim ô đây
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Dẫn khỏi xứ này toàn dân
	    \markup { \underline "Ít-ra-" } en
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Dẫn tôi tớ Ngài bình yên băng quan
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Đấng đã đánh phạt nhiều vua uy phong
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Để thành kỷ phân của Ít -- ra -- en
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "8."
      \override Lyrics.LyricText.font-shape = #'italic
	    Đấng nuôi dưỡng hoài ngàn muôn sinh linh
    }
  >>
  \override Lyrics.LyricText.font-series = #'bold
  Muôn đời Chúa vẫn trọn tình thương
  \revert Lyrics.LyricText.font-series
  
  <<
    {
      \set stanza = "1."
      Hãy tạ ơn Chúa, Thần của chư thần
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chúa đà căng đất ở giữa thủy triều
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Với ngàn tinh tú dọi sáng đêm trường
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Với bàn tay Chúa mạnh mẽ uy quyền
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Nhấn chìm vương tướng dòng giống Ai Cập
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Giết sạch vương bá quyền thế oai hùng
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Giữa thời nguy khó Ngài nhớ ta hoài
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "8."
      \override Lyrics.LyricText.font-shape = #'italic
	    Hãy tạ ơn Chúa ngự chốn cửu trùng
    }
  >>
  \override Lyrics.LyricText.font-series = #'bold
  Muôn đời Chúa vẫn trọn tình thương
  \revert Lyrics.LyricText.font-series
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 10\mm
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
  %ragged-bottom = ##t
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
