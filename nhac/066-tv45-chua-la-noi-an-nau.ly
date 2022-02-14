% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Chúa Là Nơi Ẩn Náu" }
  composer = "Tv. 45"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 e8 |
  f4. d8 |
  g g e (g) |
  a4. g8 |
  c a4 a16 (c) |
  d4 r8 b16 (a) |
  c8 d g, e |
  a4. a8 |
  e d g e16 (d) |
  c2 ~ |
  c4 r8 \bar "||" \break
  
  g'8 ~ |
  g c c c |
  b4 e8 d ~ |
  d b d g, |
  c4 r8 f, ~ |
  f f f f |
  a4 g8 c ~ |
  c b c e |
  a,4 r8 g |
  d'4. d8 ~ |
  d e d b |
  c2 ~ |
  c4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r8 |
  R2*9
  r4.
  g'8 ~ |
  g e e e |
  g4 c8 g ~ |
  g g f f |
  e4 r8 d ~ |
  d d d c |
  f4 f8 e ~ |
  e d e [c] |
  f4 r8 e |
  f4. f8 ~ |
  f [c] f g |
  e2 ~ |
  e4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Thiên Chúa là nơi ta ẩn náu,
      là sức mạnh của ta,
      Ngài luôn sẵn sàng trợ giúp
      lúc ta gặp bước cơ cùng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Thiên Chúa ngự ngay trong thành thánh,
	    thành không hề chuyển lay,
	    Ngài lên tiếng là vạn quốc
	    náo động toàn cõi địa cầu.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Mau đến mà xem công trình Chúa
	    làm kinh hoàng càn khôn,
	    Dẹp chinh chiến trên trần thế,
	    giáo gươm bẻ gẫy tan tành.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Hãy biết rằng Ta đây là Chúa,
	    hằng thống trị ngàn dân,
	    Là Thiên Chúa muôn hiển hách,
	    vẫn luôn ở với nhân trần.
    }
  >>
  \set stanza = "ĐK:"
  Dù trái đất biến động,
  núi cao sập xuống đại dương,
  Biển ầm ầm dậy sóng,
  Triều dâng ngả nghiêng
  <<
    { núi đồi }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \override Lyrics.LyricText.font-shape = #'italic
	    đồi núi
	}
  >>
  thì ta đây vẫn không sợ chi.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2))
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
    \override Lyrics.LyricSpace.minimum-distance = #2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
