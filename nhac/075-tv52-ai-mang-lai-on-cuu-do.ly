% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Ai Mang Lại Ơn Cứu Độ"
  composer = "Tv. 52"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4. a8 d,16 (f) g8 |
  g4 e16 (d) g8 |
  c,4. c8 |
  f (e) f (g) |
  \slashedGrace { a16 ( } g2) ~ |
  g8 bf a a |
  c8. d,16 d (f) g8 |
  g4 e8 d |
  g8. c,16 c8 e |
  f2 ~ |
  f4 \bar "||"
  
  f8 bf |
  bf4 bf8. c16 |
  a8 f g a |
  d,4. d8 |
  c4 a'16 (bf) a8 |
  g2 ~ |
  g4 g8 a |
  d,8. d16 d8 g |
  c,4 c8 a' |
  bf8. a16 g8 c |
  c4 d8 bf |
  bf8. c16 g8 e |
  f2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r4. |
  R2*9
  r4
  
  f8 ef |
  d4 d8. c16 |
  f8 d c c |
  bf4. bf8 |
  a4 f'16 (g) f8 |
  c2 ~ |
  c4 c8 c |
  b!8. b16 b8 b |
  c4 c8 f |
  g8. f16 e8 g |
  a4 bf8 f |
  g8. f16 e8 c |
  f2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Những kẻ ngu si tự nhủ thầm:
      làm chi có Chúa,
      Chúng ra hư đốn, bỉ ổi vô luân,
      Đâu còn thấy người làm điều ngay.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Chúa ở thiên cung đưa mắt nhìn
	    tìm trong nhân thế
	    Có ai đâu vẫn còn trọng lương tri
	    Luôn tìm Chúa trọn niềm thành tin.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Hết thảy nhân gian xa chính lộ,
	    làm chuyện hư đốn
	    Ngước trông đây đó mà tìm không ra
	    Một người biết làm việc thiện thôi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Những kẻ gian ngoa đâu hiểu gì,
	    chẳng kêu xin Chúa
	    Sống trên xương máu đồng bào ta đây,
	    Nhưng bọn chúng rồi bị diệt vong.
    }
  >>
  \set stanza = "ĐK:"
  Từ Si -- on, ai sẽ mang lại ơn cứu độ cho nhà Is -- ra -- el.
  Khi Chúa đổi vận mạng dân Ngài,
  nhà Gia -- cop vui mừng biết mấy,
  Is -- ra -- el hớn hở dường bao.
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 10\mm
  bottom-margin = 10\mm
  left-margin = 10\mm
  right-margin = 10\mm
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
        \notBePhu -3 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #0.7
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
