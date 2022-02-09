% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Từ Cùng Cõi Địa Cầu" }
  composer = "Tv. 60"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4. a16 a f'8 e |
  d8. g16 g8 g |
  a4. g16 f |
  g8 g a f |
  e4 r8 a, |
  f' e16 d e8 (f) |
  g4. g8 |
  a8. c16 c8 cs |
  \once \stemDown d4 r8 \bar "||"
  
  a |
  d, f16 f e8 (g) |
  a4. bf16 (a) |
  g4 r8 f16 g |
  a8 a f16 (e) d8 |
  e2 ~ |
  e4 r8 f |
  e d16 c d8 (e) |
  a,4 e'8 d |
  f4. f8 |
  e8. a16 a8 a |
  d,2 ~ |
  d8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  a16 a f'8 e |
  d8. c16 d8 e |
  f4. e16 d |
  e8 e f d |
  cs4 r8 a |
  f' e16 d cs8 (d) |
  e4. e8 |
  f8. a16 <a f>8 <g e> |
  <f d>4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Từ cùng cõi địa cầu con kêu lên Chúa
  Khi lòng con thao thức rã rời.
  Tảng đá cao vời vợi kia,
  Nguyện Ngài cho con lên tới
  <<
    {
      \set stanza = "1."
      Chúa là nơi con tìm đến nàu thân,
      thành kiên cố chống lại địch quân,
      Ước chi con được sống hoài trong lều thánh
      Nương mình dưới bóng cánh Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Chính Ngài, ôi thân lạy Chúa chí nhân
	    đà nghe tiếng khấn nguyện của con,
	    Đã cho con được hưởng phần cơ nghiệp Chúa
	    Cho kẻ biết kính ái Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Suốt đời con xin đàn hát Thánh Danh,
	    lời tuyên khấn giữ trọn nào ngơi,
	    Chúa cho con được sống hoài trong hạnh phúc,
	    Ân tình tín nghĩa giữ gìn.
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
    \override Lyrics.LyricSpace.minimum-distance = #1.2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
