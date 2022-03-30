% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Nào Ta Lên Đền Thờ" }
  composer = "Tv. 121"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4 e8 c |
  c f16 f d8 f |
  g4 r8 g |
  c8. c16 b8 c |
  d e (e4 ~ |
  e) f8. e16 |
  d8 d d4 ~ |
  d8 b c8. d16 |
  c8 \slashedGrace { \once \stemDown a16 ( } g8) e f ~ |
  f f d16 (g) e (d) |
  c2 \bar "||"
  
  g'8 g g g ~ |
  g a f g16 (f) |
  d4 d8 e |
  e8. d16 g8 e16 (d) |
  c2 ~ |
  c4 c8 f |
  d8. g16 e8 \slashedGrace { \parenthesize e16 ( } g8)
  a2 ~ |
  a8 d,16 (g) e8 d |
  b \slashedGrace { \parenthesize b16 ( } d4)
  c8 |
  c2 ~ |
  c4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  e8 c |
  c f16 f d8 f |
  g4 r8 f |
  e8. e16 d8 e |
  g c (c4 ~ |
  c) a8. c16 |
  b8 a g4 ~ |
  g8 g a8. g16 |
  e8 [e] c d ~ |
  d d b b |
  c2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Vui chừng nào khi thiên hạ bảo tôi:
  Nào ta lên đền thờ Thiên Chúa.
  Hỡi Giê -- ru -- sa -- lem
  Giờ đây chúng ta đã dừng chân,
  nơi cửa nội thành.
  <<
    {
      \set stanza = "1."
      Giê -- ru -- sa -- lem khác nào đô thị
      Được xây nên một khối vẹn toàn.
      Từng chi tộc, chi tộc
      \markup { \italic \underline "của" }
      Chúa,
      Trẩy hội lên đền
      \markup { \italic \underline "ở" }
      nơi đây.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Con dân hân hoan tiến về nơi này
	    Cùng tuân theo lệnh Chúa ban truyền,
	    Tại đây đặt ngai tòa Đa -- vít
	    Sẽ công minh xử xét con dân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Mong sao Sa -- lem mãi được an bình,
	    Thịnh hưng cho kẻ mến yêu thành,
	    Mọi lũy thành luôn được
	    \markup { \italic \underline "ổn" }
	    cố
	    Với bao dinh thự mãi an ninh.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Do bao anh em nghĩa tình thân thuộc,
	    Lòng ta mong thành mãi an bình,
	    Vì cung điện, cung điện
	    \markup { \italic \underline "của" }
	    Chúa,
	    Chúc ngươi luôn hạnh phúc an vui.
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
