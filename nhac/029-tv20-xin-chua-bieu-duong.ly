% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Xin Chúa Biểu Dương"
  composer = "Tv. 20"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 f8 |
  g e f d |
  c4. a16 c |
  f8 e \slurDashed f (g) |
  a4 r8 f |
  bf bf4 c8 |
  g8. e16 d8 c |
  f2 ~ |
  f4 \bar "||" \break
  
  c4 |
  a'4 a8 bf |
  g8. e16 f8 d |
  c4 c8 a' |
  g4. f8 |
  g8. g16 bf8 c |
  f,4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r8 |
  R2*7
  r4
  c |
  f f8 g |
  e8. c16 d8 b! |
  c4 c8 f |
  e4. d8 |
  c8. c16 d8 bf |
  a4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Xin Chúa biểu dương uy lực
      để nhà vua được sung sướng.
      Ngài chiến thắng khiến vua hớn hở dường bao.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Điều vua ước nguyện trong lòng,
	    Ngài đã cho được như ý,
	    điều khấn vái Cúa không ngoảnh mặt làm ngơ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Tay Cháu tặng ban ân lộc,
	    Đội triều thiên vàng
	    \markup { \italic \underline "cho vua" }
	    đó,
	    Và Chúa khiến đức vua tuổi thọ dài lâu.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Xin Chúa vùng lên uy hùng
	    để địch quân phải chạy trốn,
	    Ngài chiến thắng chúng con vui mừng đàn ca.
    }
  >>
  \set stanza = "ĐK:"
  Lạy Chúa, xin đứng lên mạnh mẽ oai hùng
  để chúng con mừng vui đàn ca chúc tụng.
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
