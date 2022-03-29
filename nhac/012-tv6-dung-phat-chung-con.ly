% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Đừng Phạt Chúng Con" }
  composer = "Tv. 6"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  g8 f g a |
  d,4. a8 |
  d4 bf'8 (a) |
  g4 r8 d |
  d'2 |
  r8 c c c |
  bf8. d16 g,8 g |
  a2 |
  f!?8 f g f |
  d4. d8 |
  a' a4 g8 |
  bf2 |
  a8 a bf g |
  a4. d,8 |
  a' a4 bf8 |
  g2 \bar "||"
  
  g4. a16 (g) |
  f8. d16 \tuplet 3/2 { a'8 a
  \afterGrace g8 ({
    \override Flag.stroke-style = #"grace"
    a16)} }
  \revert Flag.stroke-style

  bf2 |
  a4. bf16 (a) |
  g4 \tuplet 3/2 { f8 ef ef } |
  d2 |
  bf8 ef ef c |
  d8. d16 \tuplet 3/2 { d8 g a } |
  a2 |
  a8 c ef d |
  d8. d16 \tuplet 3/2 { c8 bf f } |
  g2 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  g8 f g a |
  d,4. a8 |
  d4 bf'8 (a) |
  g4 r8 d |
  bf'2 |
  r8 a a a |
  g8. f16 ef8 ef |
  d2 |
  f!?8 f g f |
  d4. d8 |
  c d4 d8 |
  g2 |
  a8 a bf g |
  a4. d,8 |
  c d4 c8 |
  bf2
  
  R2*9
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Xin đừng theo nghĩa nộ mà phạt chúng con,
  Lạy Chúa, trong cơn lôi đình chớ trừng trị con.
  Xin thương xót con cùng, vì thân con kiệt sức,
  Xin thương chữa trị con vì xương cốt rã rời.
  <<
    {
      \set stanza = "1."
      Xin đoái lại mà ban ơn giải thoát,
      Xin cứu con theo lượng hải hà.
      Vì giữa chốn tử vong nào còn ai nhớ Chúa,
      Và trong cõi âm ty có ai ca tụng Ngài?
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Con mỏi mòn vì kêu van thảm thiết,
	    Đêm, mỗi đêm châu lệ chảy dài,
	    Dòng nước mắt hòa chan,
	    giường mền con ướt đẫm,
	    Vì muôn nỗi thương đau, mắt con lu mờ rồi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Quân ác thù hãy mau mau tẩu thoát,
	    Nay Chúa nghe ta khẩn nguyện rồi.
	    Ngài đã đáp lời tôi,
	    làm địch quân khiếp hãi,
	    Vội quay bước theo nhau rút lui trong tủi nhục.
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
  %page-count = #1
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
    \override Lyrics.LyricSpace.minimum-distance = #1
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
