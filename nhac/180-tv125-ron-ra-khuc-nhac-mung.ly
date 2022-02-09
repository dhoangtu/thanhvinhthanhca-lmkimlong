% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Rộn Rã Khúc Nhạc Mừng" }
  composer = "Tv. 125"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4 f8 g16 f |
  e8 f f d |
  c4. c16 a |
  c8 e g g |
  f4 r8 d |
  d8. g16 \tuplet 3/2 { g8 g f } |
  bf4 r8 a |
  a8. g16 \tuplet 3/2 { c8 c e, } |
  f4 r8 \bar "||"
  
  c16 f |
  f4 \tuplet 3/2 { f8 e a } |
  \slashedGrace { d,16
                  \tweak extra-offset #'(0 . 1.2)
                  _(f } d4.) a'8 |
  f bf4 a8 |
  g4 r8 a16 f |
  e4 \tuplet 3/2 { d8 g g } |
  a4. a8 |
  g c4 c8 |
  f,4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r4 |
  R2*7
  r4.
  c16 bf |
  a4 \tuplet 3/2 { d8 c c } |
  bf4. f'8 |
  d g4 f8 |
  e4 r8 f16 d |
  c4 \tuplet 3/2 { b!8 b c } |
  f4. f8 |
  e e4 e8 |
  f4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Khi Chúa dẫn tù Si -- on trở về,
      ta tưởng mình như giữa giấc mơ,
      Ngoài miệng vang vang câu cười nói,
      Trên môi rộn rã khúc nhạc mừng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Hôm ấy khắp bàn dân nghe luận đàm:
	    ôi việc vàn tay Chúa lớn lao,
	    Việc Ngài thi công cao trọng quá,
	    Con nghe hồn chất ngất niềm vui.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Xin Chúa dẫn đường con dân trở về
	    như chuyển dòng con suối phía nam,
	    Nghẹn ngào ra đi gieo hạt giống,
	    Mai sau gặt hái sẽ mừng vui.
    }
  >>
  \set stanza = "ĐK:"
  Họ ra đi, đi mà nức nở,
  đem hạt giống tung gieo.
  Lúc trở về, về trong vui sướng
  vai nặng gánh lúa vàng.
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
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
