% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Mừng Thiên Chúa Tôi Thờ" }
  composer = "Gđ. 16,1-2.13-15"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 c8 |
  c a4 g8 |
  e8. f16 a8 g ~ |
  g4 r8 f |
  f f4 d8 |
  g8. e16 d8 c ~ |
  c4 r8 c |
  e8. f16 g8 g ~ |
  g g d'16 (c) bf8 |
  c4 r8 c |
  bf bf4 g8 ~ |
  g c a g |
  f2 \bar "||"
  
  c8. f16 a8 f |
  e8 d r a' |
  bf8. a16 f8 g |
  a4 r8 f |
  d'8. d16 g,8 bf |
  c8. g16 c8 a16 (g) |
  d8. c16 g'8 g16 (a) |
  f4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r8 |
  R2*12
  c8. f16 a8 f |
  e8 d r f |
  g8. f16 d8 e |
  f4 r8 f |
  bf8. g16 f8 d |
  e8. e16 c8 [c] |
  bf8. a16 bf8 [c] |
  a4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Thúc trống lên ca mừng Thiên Chúa tôi,
      Khua chiêng lên rộn rã biểu dương Ngài.
      Nhịp nhàng hòa vang lên bài tán tụng ca,
      Hãy suy tôn và khấn xin danh Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Chính Chúa tôi tiêu diệt họa chiến tranh,
	    Thân tôi đây được Chúa thương độ trì.
	    Ngài giựt khỏi bao tay phường bách hại tôi
	    Giấu tôi trong trại giữa dân riêng Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Hãy kính tôn suy phục Thiên Chúa đi,
	    Khi tuyên ngôn, Ngài tác tạo muôn loài,
	    Mọi vật được khai sinh nhờ Chúa thở hơi,
	    Chúa tuyên ngôn nào dám ai đương đầu.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Dẫu núi cao hay biển sâu chuyển rung,
	    Dẫu đất đá tựa sáp ong chảy mềm,
	    Thì người nào trung kiên hằng kính sợ liên,
	    Chúa khoan nhân hằng xót thương trọn niềm.
    }
  >>
  \set stanza = "ĐK:"
  Mừng Thiên Chúa tôi tôn thờ,
  tôi hát lên bài ca mới,
  Lạy Chúa vĩ đại, hiển vinh
  mạnh mẽ khôn lường nào ai sánh tầy.
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
    \override Lyrics.LyricSpace.minimum-distance = #1
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
