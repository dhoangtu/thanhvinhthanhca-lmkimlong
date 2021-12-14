% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Muôn Đời Con Ca Tụng"
  composer = "Tv. 88"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 f8 |
  e8. f16 a8 f |
  d4. c8 |
  a'8 a4 g8 |
  bf4 r8 bf16 b! |
  c8 c d c |
  a4. g8 |
  bf a4 g8 |
  f4 \fermata \bar "||" \break
  
  e8. e16 |
  f8 d4 c8 |
  a' f bf a |
  g4 g8. g16 |
  c8 c4 a8 |
  g8. bf16 a8 g |
  f4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  f8 |
  e8. f16 a8 f |
  d4. c8 |
  f8 f4 c8 |
  g'4 r8 g16 f |
  e8 f bf a |
  f4. e8 |
  g f4 e8 |
  a,4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Muôn đời con sẽ ca tụng Tình yêu thương của Chúa
  và ngàn năm con sẽ loan truyền lòng tín trung của Ngài.
  <<
    {
      \set stanza = "1."
      Vì tình yêu Ngài được thiết lập đến thiên thu,
      Lòng thành tín Chúa xây dựng mãi trên cung trời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Tầng trời chiếu dọi ngàn công trình Chúa nơi nơi,
	    Cộng đoàn các thánh ca tụng tín trung của Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Vì từ cõi trời nào ai người dám sánh vai,
	    Dù thần thánh đó, ai nào có thể so bì.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Ngài thực lẫm liệt, ngự giữa thần thánh oai linh,
	    Quần thần bái kính, suy phục Chúa cả uy hùng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Dẹp trận sóng cồn, đại dương Ngài trấn coi luôn,
	    Bầu trời trái đất, muôn loài Chúa đã tạo thành.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
	    Này bàn tay Ngài từng đã mạnh mẽ dương oai,
	    Bệ là chính nghĩa, cho thành tín đi dẫn đường.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Được tụng ca Ngài, này dân tộc phúc vinh thay,
	    Họ được tiến bước trông nhờ thánh nhan soi đường.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "8."
	    Nguyện Ngài nhớ hoài: phù du phận chúng con đây,
	    Đời người dưới thế, ôi thực quá ư mỏng dòn.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 5\mm
  bottom-margin = 5\mm
  left-margin = 7.5\mm
  right-margin = 7.5\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2.5))
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
