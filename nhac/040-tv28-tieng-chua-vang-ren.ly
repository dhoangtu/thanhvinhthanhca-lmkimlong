% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Tiếng Chúa Vang Rền"
  composer = "Tv. 28"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4 a8 a |
  bf4 bf8. a16 g8 g |
  c2 g8 g |
  a4 a8. f16 f8 d |
  c2 c8 c |
  a' a4 a8 bf g |
  c2 bf8. g16 |
  c8 e,4 g8 g g |
  \partial 8*5 f2 r8 \bar "||"
  
  \override Staff.TimeSignature.break-visibility = #end-of-line-invisible
  \time 2/4
  \partial 8 f8 |
  f8. d16 c8 a' |
  a4. bf16 bf |
  g8 c c bf |
  a4 r8 bf16 a |
  g8 g g f |
  e4. d16 d |
  d8 c e16 (g) f8 |
  f4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  f8 f |
  g4 g8. f16 f8 f |
  e2 e8 e |
  f4 f8. d16 d8 b! |
  c2 c8 c |
  f8 f4 f8 g f |
  e2 g8. e16 |
  d8 c4 b!8 c c |
  a2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Tung hô Chúa, hỡi chư vị thần thánh,
  Tung hô Chúa, Đấng quang vinh uy quyền
  Nào cùng tung hô danh Chúa rạng rỡ,
  Phủ phục bái thờ Đấng Thánh hiển linh.
  <<
    {
      \set stanza = "1."
      Tiếng Chúa vang rền sóng nước,
      vinh quang Người khiến sấm nổ tung,
      Chúa uy linh trên cơn thủy triều,
      Vang xa bao lời Chúa oai nghiêm.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Tiếng Chúa xô nhào trắc bá,
	    quất gẫy ngàn trắc bá Ly -- băng,
	    Dây Ly -- băng như dê nhảy chồm,
	    Xi -- ri -- on tựa nghé tung tăng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Tiếng Chúa tung lửa nóng cháy,
	    khiến nào động khắp cõi hoang vu,
	    Khiến xôn xao bao nhiêu rặng sồi,
	    Cây cao xanh trụi lá trơ vơ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Hô vang trong đền thánh Chúa,
	    muôn dân mừng hát ''Chúa hiển danh'',
	    Đức vua uy linh luôn hiển trị,
	    Cho con dân hưởng phúc an vui.
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
  \key f \major \time 3/4
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
    \override Lyrics.LyricSpace.minimum-distance = #0.8
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
