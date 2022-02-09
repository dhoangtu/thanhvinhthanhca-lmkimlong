% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Chúa Viếng Thăm Mặt Đất" }
  composer = "Tv. 64"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4 g8 g |
  e4. d8 |
  b'4 r8 g |
  a16 (g) e8 e16 (g) a8 |
  a4 r8 g |
  g8. c16 c8 c |
  c4 d8 b16 (a) |
  g4. a8 |
  b2 ~ |
  b4 g8 g |
  a4 b8 a16 (g) |
  e4. e8 |
  e g a e |
  d4 r8 a |
  d8. d16 fs (g) b8 |
  a4 a8 fs16 (e) |
  d8 fs4 a8 |
  g2 ~ |
  g8 \bar "||"
  
  d b'16 (c) b8 |
  a4 g8 g |
  e4. e8 |
  e8. (g16 a4) |
  \slashedGrace { fs16 ( } a8) fs16 (e) d4 ~ |
  d8 d b'16 (c) b8 |
  a4 r8 a |
  g8. c16 a8 c |
  d4 \slashedGrace { b16 ( } b8) g16 (g) |
  g4. a8 |
  b4 b8 a16 (g) |
  e4. d8 |
  g2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r4 |
  R2*17
  r8
  d8 g16 (g) g8 |
  fs4 e8 d |
  c4. c8 |
  c8. (b16 d4) |
  cs8 cs d4 ~ |
  d8 d g16 (a) g8 |
  fs4 r8 fs |
  e8. e16 fs8 a |
  b4 fs8 fs |
  e4. d8 |
  g4 g8 [d] |
  c4. c8 |
  b2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Chính đáng thay, lạy Chúa,
      Ngợi khen Ngài ở Si -- on
      Và từ Giê -- ru -- sa -- lem
      giữ trọn lời đoan hứa.
      Mọi phàm nhân hướng lên Ngài
      vì Ngài nghe tiếng kêu cầu,
      Tội tình đè nặng chúng con
      cúi xin Ngài thương thứ tha.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Diễm phúc ai được Chúa dù thương tuyển chọn thi ân,
	    Được ngụ luôn nơi khuôn viên Thánh điện Ngài hôm sớm,
	    Được đầy no phúc ân Ngài, hưởng lộc trong thánh điện Ngài,
	    Vì Ngài là vị cứu tinh, chốn hy vọng cho khắp nơi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Giữ núi non bền vững,
	    Dùng uy lực làm đai lưng.
	    Ngài truyền phong ba im hơi,
	    khiến biển động ngưng tiếng,
	    Và ngàn dân những kính sợ,
	    lặng nhìn uy phép tay Ngài,
	    cửa đoài cửa đông sớm hôm,
	    tiếng reo hò luôn vút cao.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Chúa viếng thăm mặt đất,
	    Đổ mưa gội nhuần nơi nơi,
	    Ruộng đồng mênh mông xanh tươi,
	    suối chảy tràn muôn lối,
	    Đời giầu sang Chúa ban tặng,
	    dạt dào nương lùa ươm vàng,
	    từng mùa Ngài đổ phúc ân,
	    trải hoa màu theo vết chân.
    }
  >>
  \set stanza = "ĐK:"
  Vùng đất hoang vu nay xanh rì ngọn cỏ,
  Khắp nương đồi rực rỡ khoe tươi,
  chiên cừu phủ ngập đồng xanh,
  Lúa trải vàng thung lũng,
  Tiếng hát hò vọng xa.
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
  system-system-spacing = #'((basic-distance . 0.1)
                             (padding . 1.5))
  ragged-bottom = ##t
}

TongNhip = {
  \key g \major \time 2/4
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
    \override Lyrics.LyricSpace.minimum-distance = #1
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
