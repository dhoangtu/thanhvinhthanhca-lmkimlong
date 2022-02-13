% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Tựa Trầm Hương" }
  composer = "Tv. 140"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 f8 |
  f8. e16 f8 a |
  d,4. c16 c |
  f8 e f g |
  a4 r8 f |
  bf8. bf16 bf8 bf |
  bf4. g16 g |
  c8 d bf g |
  f2 \bar "||"
  
  f8. a16 d,8 d |
  g4. f8 |
  bf4 \tuplet 3/2 { bf8 g d' } |
  c2 ~ |
  c4 \tuplet 3/2 { g8 g g } |
  a8. bf16 g8 e |
  c'4. bf16 bf |
  g8. c,16 \tuplet 3/2 { g'8 g g } |
  f2 ~ |
  f4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  f8 |
  f8. e16 f8 a |
  d,4. c16 bf |
  a8 c d e |
  f4 r8 f |
  d8. d16 e8 f |
  g4. g16 f |
  e8 f g e |
  f2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Xin cho lời con khấn cầu
  tựa trầm hương nhẹ bay lên Chúa,
  Và xin tay con nâng cao
  được nhận như lễ dâng ban chiều.
  <<
    {
      \set stanza = "1."
      Xin Chúa nhận lời con thành tâm van nài Chúa luôn.
      Lẳng lặng mà nghe tiếng con gọi Chúa,
      Mau thương tình mà tiếp đáp, Chúa ơi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Xin giữ miệng con
	    Và xin canh chừng lưỡi con.
	    Đừng để lòng con hướng theo sự dữ,
	    Kẻo trở thành đồng lõa với ác nhân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Khi chúng bày tiệc vui
	    Nào con đâu thèm khát chi,
	    Thà được hiền nhân đánh con, dạy dỗ,
	    Hơn nghiêng đầu để chúng xức thuốc thơm.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Ngay giữa bọn tàn hung
	    Này con kêu cầu Chúa luôn.
	    Đầu mục họ nay té xô vào đá,
	    Riêng con này được Chúa mãi lắng nghe.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Con ngước nhìn Ngài luôn
	    Là nơi con tìm náu thân.
	    Nguyện đừng để con vướng sa cạm bẫy
	    Quân gian tà gài mắc khắp đó đây.
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
