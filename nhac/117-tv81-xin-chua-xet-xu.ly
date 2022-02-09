% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Xin Chúa Xét Xử" }
  composer = "Tv. 81"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 a16 f |
  e4. d16 (e) |
  c8 c f (g) |
  a4. f8 |
  bf8. a16 c8 d |
  g,4 r8 a16 f |
  e4. e16 (f) |
  d8 c e16 (f) a8 |
  g4. f16 bf |
  bf8 bf g c |
  f,4 \bar "||" \break
  
  f8 c |
  a'8. a16 g8 c |
  f,8. g16 d8 d |
  c4 r8 c |
  a'4 bf8 a |
  g8. bf16 c8 e, |
  f2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r8 |
  R2*9
  r4
  
  f8 c |
  f8. f16 e8 e |
  d8. c16 b!8 b |
  c4 r8 c |
  f4 g8 f |
  e8. d16 c8 c |
  a2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Chúa chủ tọa cả triều đình thiên quốc,
      xử án giữa muôn lãnh thần.
      Tới bao giờ các ngươi còn xử bất công,
      Còn thiên tư bao phường ác tàn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Hãy bênh vực kẻ mọn hèn côi cút,
	    bầu chữa những ai khốn cùng,
	    Cứu kẻ nghèo khỏi tay của bọn ác nhân,
	    Giải thoát hết những người yếu hèn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Nhớ phận mình sẽ một ngày phải chết,
	    một kiếp phàm nhân khác gì,
	    Đến một ngày sẽ bị sụp đổ nát tan
	    Tựa như bao quan quyền thế trần.
    }
  >>
  \set stanza = "ĐK:"
  Muôn lạy Chúa, xin Ngài đứng dậy xét xử địa cầu,
  Vì Chúa nắm vương quyền trên hết mọi dân.
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
    \override Lyrics.LyricSpace.minimum-distance = #1.2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
