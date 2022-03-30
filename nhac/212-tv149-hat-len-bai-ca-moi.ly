% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Hát Lên Bài Ca Mới" }
  composer = "Tv. 149"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 c8 |
  d4 f8 (g) |
  a4 bf8 bf |
  a8. c16 f,8 a |
  g4 r8 g16 d |
  d8 g e d |
  c8. c16 a'8 a |
  g c e, g |
  f4 r8 \bar "||"
  
  e16 e |
  e8. d16 \tuplet 3/2 { d8 e d } |
  c4 r8 c16 g' |
  g8. g16 \tuplet 3/2 { g8 f g } |
  a4 r8 bf16 bf |
  bf8 bf d bf |
  g4 r8 d16 d |
  g8 e c d |
  f4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  c8 |
  d4 f8 (g) |
  a4 d,8 d |
  f8. e16 d8 f |
  c4 r8 c16 c |
  b!8 b b b |
  c8. c16 f8 f |
  e d c bf |
  a4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Một bài ca mới, hãy hát lên chúc tụng Chúa đi,
  giữa cộng đoàn tín trung dân Ngài,
  Nào hãy hát lên chúc tụng Chúa đi.
  <<
    {
      \set stanza = "1."
      Ít -- ra -- en vui trong Đấng tạo thành,
      Và Si -- on tôn Vua là Thiên Chúa
      Ca vang lên hoan chúc Danh Ngài,
      Hòa nhịp sáo, cung đàn ngợi khen.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ban ân thiêng cho ai sống thanh bần
	    Và yêu thương dân riêng Ngài luôn mãi,
	    Ai kiên trung vinh phúc rỡ ràng,
	    Họ nhảy múa, reo hò mừng vui.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Vang ca lên tung hô Chúa uy quyền,
	    Cầm trong tay thanh gươm trần hai lưỡi,
	    Bao vương công đem xích cổ vào.
	    Mọi kẻ hiếu trung rầy hiển vinh.
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
    \override Lyrics.LyricSpace.minimum-distance = #1.2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
