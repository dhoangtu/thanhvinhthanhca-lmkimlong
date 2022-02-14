% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Vinh Phúc Ai Tôn Sợ Chúa" }
  composer = "Tv. 127"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4 e8 f16 (e) |
  d4. e16 (d) |
  c8. c16 e8 d |
  g4 g8 g |
  c8. a16 d8 c |
  b2 ~ |
  b4 g8 g |
  f4. e8 |
  d8. d16 d8 \slashedGrace { d16 ( } g8) |
  c,4 g'8 g |
  g8. d'16 d8 b |
  c2 ~ |
  c4 r8 \bar "||"
  
  c,16 c |
  c8 e16 e e8 d |
  f2 ~ |
  f8 e16 d g8 g |
  a4 r8 g16 g |
  c8 a16 a f'8 e |
  d2 ~ |
  d8 b16 b a8 g |
  c4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  e8 f16 (e) |
  d4. e16 (d) |
  c8. c16 e8 d |
  g4 g8 f |
  e8. f16 fs8 a |
  g2 ~ |
  g4 g8 g |
  f4. e8 |
  d8. d16 d8 \slashedGrace { d16 ( } g8) |
  c,4 g'8 f |
  e8. f16 f8 d |
  e2 ~ |
  e4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Vinh phúc thay những bạn nào tôn sợ Chúa,
  Hằng tìm theo đường lối của Ngài.
  Bao công quả tay bạn,
  bạn được hưởng dùng,
  Đời bạn thực lắm phúc nhiều may.
  <<
    {
      \set stanza = "1."
      Vợ hiền bạn như cây nho đầy trái
      trong nội cung gia thất,
      Và đàn con tựa những nhánh ô -- lieu
      xúm xít quanh bàn ăn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Người một niềm kiên trung tôn sợ Chúa
	    được hồng ân chan chưa,
	    Nguyện cầu Chúa từ thành thánh Si -- on
	    chúc phúc cho bạn luôn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Cầu bạn được thêm đông con nhiều cháu,
	    mong bạn cao niên tuế,
	    Được nhìn cảnh phồn thịnh của Gia -- liêm.
	    Chúc Ích -- diên bình yên.
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
