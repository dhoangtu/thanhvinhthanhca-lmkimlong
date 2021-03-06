% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Vui Sống Bên Nhau" }
  composer = "Tv. 132"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4 f8. ^> g16 |
  e8 f4 ^> d8 |
  c4. a'8 |
  a f16 a bf8 a |
  g4 r8 g |
  e8. g16 f8 d |
  c4. a'8 |
  g bf16 bf d,8 e |
  f4 r8 \bar "|." \break
  
  f8 |
  f8. d16 d (f) g8 |
  g4. f8 |
  bf8. bf16 g (bf) c8 |
  c4 r8 a |
  a bf bf a16 (g) |
  d4. \slashedGrace { e16 ( } g8) |
  c, c a'16 (g) e8 |
  f4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  f8. ^> g16 |
  e8 f4 ^> d8 |
  c4. f8 |
  f d16 f g8 f |
  c4 r8 b! |
  c8. c16 d8 b! |
  c4. f8 |
  e d16 c bf8 c |
  a4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Ôi tốt đẹp, ôi ngọt ngào:
  Anh em được vui sống bên nhau,
  Như dầu quý chảy trên đầu, xuống râu,
  xuống áo chầu A -- ran.
  
  Như sương từ đỉnh Khe -- mon,
  tỏa xuống núi đồi Si -- on,
  Nơi đây Chúa xuống ơn lành,
  chính là hạnh phúc trường sinh.
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

% mã nguồn cho những chức năng chưa hỗ trợ trong phiên bản lilypond hiện tại
% cung cấp bởi cộng đồng lilypond khi gửi email đến lilypond-user@gnu.org
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
% kết thúc mã nguồn

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
    \override LyricHyphen.minimum-distance = #2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
