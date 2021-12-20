% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Ơn Phù Trợ Từ Thiên Chúa"
  composer = "Tv. 120"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 e8 |
  e8. d16 c8 g' |
  e a r g16 fs |
  fs8 g a fs |
  g e r a16 g |
  g8 a c b |
  c d4 e8 ~ |
  e g, d' e |
  \once \stemDown c2 \bar "||" \break
  
  e,8. f16 d8 g |
  c,4. c16 c |
  c8 c e f |
  f2 |
  e8. d16 a'8 fs |
  g4. a16 a |
  g8 f d d |
  c4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  e8 |
  e8. d16 c8 g' |
  e a r e16 d |
  d8 e c d |
  b c r f!?16 f |
  e8 f a g |
  e g4 c8 ~ |
  c e, f g |
  <e c>2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Ngước mắt tôi nhìn lên rặng núi:
  Ơn phù trợ tôi đến từ nơi nao?
  Ơn phù trợ tôi đến từ Thiên Chúa,
  Đấng dựng nên đất trời.
  <<
    {
      \set stanza = "1."
      Xin Đấng canh giữ bạn,
      Đừng để bạn trượt chân lỡ bước,
      Xin Ngài chớ ngủ quên.
      Chúa Ích -- diên ngủ quên sao đành.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Tay Chúa nâng đỡ bạn,
	    Ngài gần kề chở che tiếp giúp,
	    Cung hằng với Vầng Ô
	    Sớm tới khuya chẳng gây hại gì.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Không vướng chi bất hạnh,
	    Đời bạn thực bình an diễm phúc.
	    Đây mọi bước vào ra,
	    Chúa vẫn luôn chở che khôn rời.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 15\mm
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
  %page-count = #1
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
        \notBePhu -3 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
