% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Ca Tụng Chúa Đi" }
  composer = "Tv. 150"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4. f8 e g |
  f8. d16 c8 a' |
  a4 \bar "" \break
  
  bf8 a |
  g g16 g d'8 b! |
  c2 ~ |
  c8 \bar "" \break
  a g bf |
  a f16 f g8 a |
  d,4 \bar "" \break
  
  f8 d |
  c g'16 g d8 e |
  f2 ~ |
  f8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  f8 e g |
  f8. d16 c8 f |
  f4 g8 f |
  c c16 c f8 g |
  e2 ~ |
  e8 f e g |
  f d16 d c8 c |
  bf4 d8 bf |
  a bf16 bf b!8 c |
  a2 ~ |
  a8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \override Lyrics.LyricText.font-series = #'bold
      Ca tụng Chúa đi
      \revert Lyrics.LyricText.font-series
      \set stanza = "1."
      Trong đền thánh Chúa
      \override Lyrics.LyricText.font-series = #'bold
      Tán dương Ngài
      \revert Lyrics.LyricText.font-series
      Từ tận cõi trời cao
      \override Lyrics.LyricText.font-series = #'bold
      Ca tụng Chúa đi
      \revert Lyrics.LyricText.font-series
      Vì kỳ công vĩ đại
      \override Lyrics.LyricText.font-series = #'bold
      Tán dương Ngài
      \revert Lyrics.LyricText.font-series
      Đấng lẫm liệt uy phong.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \repeat unfold 4 { _ }
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Cung cầm tiếng sắt
	    \repeat unfold 3 { _ }
	    Tù và hãy họa theo
	    \repeat unfold 4 { _ }
	    Nhịp nhàng theo vũ điệu
	    \repeat unfold 3 { _ }
	    Tiếng sáo hòa cung tơ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \repeat unfold 4 { _ }
	    \set stanza = "3."
	    Theo nhịp trống thúc
	    \repeat unfold 3 { _ }
	    Rộn ràng tiếng phèng la
	    \repeat unfold 4 { _ }
	    Chủm chọe xen tiếng cồng
	    \repeat unfold 3 { _ }
	    Hỡi tất cả sinh linh.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 3))
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
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
