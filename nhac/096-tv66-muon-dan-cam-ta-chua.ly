% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Muôn Dân Cảm Tạ Chúa" }
  composer = "Tv. 66"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  f8 g e (d) |
  c4. a'8 |
  a4 r8 c |
  d,16 (f) g8 g e16 (d) |
  c8 e4 g8 |
  f2 |
  e8. e16 e8 e |
  a4 f8 bf |
  bf4 g8 c |
  c4. d8 |
  bf g4 c8 |
  f,4 r8 \bar "||"
  
  f |
  f8. g16 d (f) d8 |
  c4 r8 c |
  a'4. a8 |
  a8. bf16 g (a) g8 |
  f2 ~ |
  f4 f8 f |
  d'4. d8 |
  bf c4 a8 |
  g4 f8 f16 (g) |
  a4. g16 (f) |
  d8. f16 d8 c |
  f2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  R2*11
  r4.
  f8 |
  f8. g16 d (f) d8 |
  c4 r8 c |
  f4. f8 |
  f8. d16 e8 e |
  f2 ~ |
  f4 f8 f |
  bf4. bf8 |
  g8 a4 f8 |
  e4 d8 d16 (c) |
  f4. c8 |
  bf8. d16 bf8 bf |
  a2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Xin Chúa thương tình chúc phúc
      Chiếu tỏa tôn nhan rạng ngời trên chúng con,
      Để hoàn cầu nhận thấy đường lối Chúa,
      Và muôn dân biết ơn Ngài cứu độ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Nay Chúa cai trị các nước,
	    Lãnh đạo công minh trên ngàn muôn quốc gia,
	    nào người người hợp tiếng cảm mến Chúa,
	    Và nơi nơi hãy chung lời cám tạ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Hoa trái nương đồng bát ngát,
	    Chúa của ta nay ban tặng muôn phúc ân,
	    nguyện Ngài hằng đổ xuống lộc phúc mãi,
	    Nguyện muôn phương sẽ tôn sợ Chúa hoài.
    }
  >>
  \set stanza = "ĐK:"
  Muôn dân hãy cảm tạ Ngài,
  lạy Chúa, muôn dân hãy cảm tạ Ngài,
  Và vạn quốc hãy mừng vui reo hò
  vì Ngài đến thống trị khắp cõi trần ai.
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
  page-count = 1
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
    \override Lyrics.LyricSpace.minimum-distance = #0.8
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
