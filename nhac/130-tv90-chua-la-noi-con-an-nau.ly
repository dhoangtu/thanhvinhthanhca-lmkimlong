% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Chúa Là Nơi Con Ẩn Náu"
  composer = "Tv. 90"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 c8 |
  a a16 f bf8 a |
  g4. g8 |
  g g16 e f8 d |
  c4 r8 c |
  g'8 g e4 |
  f8 bf4 g8 |
  g8. c16 c8 bf16 (c) |
  d4. bf8 |
  d g,4 bf8 |
  c4 a8 a |
  g (bf a) g |
  f2 \bar "||"
  
  f8. a16 d,8 f |
  g4. g8 |
  f8. d16 g8 e16 (d) |
  c4. c8 |
  d f g f16 (g) |
  a4 c8 f, |
  g8. f16 d8 f |
  g \slashedGrace { e16 ( } d4) g8 |
  d4 r8 g, |
  c e16 (f) g8 g ~ |
  g bf bf c |
  c4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  a8 |
  f f16 d g8 f |
  e4. c8 |
  b! b16 c d8 b |
  c4 r8 c |
  g' g e4 |
  ef8 d4 f8 |
  e8. e16 f8 g16 (f) |
  bf4. g8 |
  f e4 d8 |
  e4 f8 f |
  e4. e8 |
  f2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Hỡi ai nương tựa Đấng Tối Cao,
  Nép bóng Đấng Toàn Năng uy quyền,
  Hãy thân thưa rằng:
  Lạy Chúa, Ngài là nơi con ẩn náu,
  là đồn lũy chở che,
  con tin tưởng nơi Ngài.
  <<
    {
      \set stanza = "1."
      Ngài giữ gìn bạn luôn cho khỏi dò lưới quân thù,
      Khỏi mọi tai ương tàn khốc.
      Chúa chở che cho bạn ẩn thân nơi cánh Ngài,
      Lòng Ngài thủy chung là khiên che thuẫn đỡ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Sợ hãi gì đêm đen với khí,
	    Dẫu kề bên muôn vạn người lao đao ngã gục,
	    Một mình bạn yên thân không chi vướng mắc.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Bạn ngước nhìn mà coi số phận của lũ gian tà,
	    Bạn tìm nương thân ở Chúa,
	    Chúa truyền cho thiên thần trông coi mọi lối đường
	    Để bạn khỏi khi nao sa chân vấp đá.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Đạp rắn độc hùm thiêng, dẵm sư tử với long đầu,
	    Vì bạn cậy trông Lời Chúa:
	    Lúc hiểm nguy kêu cầu lên Ta,
	    Ta đáp lời, Ngàn đời được no say ân thiêng cứu rỗi.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 10\mm
  right-margin = 10\mm
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
        \notBePhu -3 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #0.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
