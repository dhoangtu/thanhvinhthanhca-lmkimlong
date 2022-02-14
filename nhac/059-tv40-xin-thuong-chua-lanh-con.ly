% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Xin Thương Chữa Lành Con" }
  composer = "Tv. 40"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 c8 |
  d4 \tuplet 3/2 { a8 b a } |
  f4. e8 |
  b'4 r8 c |
  a4 \tuplet 3/2 { g8 a c } |
  d8. e16 \tuplet 3/2 { b8 c b } |
  a4 r8 \bar "||"
  
  e8 |
  e8. a16 c8 c |
  b4 b8 b |
  a8. d16 c8 b |
  e4 r8 c |
  d4 b8 c |
  a b4 gs8 |
  a2 ~ |
  a4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r8 |
  R2*5
  r4.
  
  e8 |
  e8. a16 a8 a |
  e4 e8 e |
  f8. f16 a8 a |
  gs4 r8 a |
  b4 gs8 a |
  f d4 e8 |
  c2 ~ |
  c4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Phúc thay ai biết thương kẻ nghèo khó,
      Lúc họ gặp cảnh nguy nan Chúa thương sẽ cứu độ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chúa thương săn sóc bảo vệ mạng sống,
	    Suốt đời được hưởng an vui,
	    thoát mưu ác quân thù.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Mỗi khi đau yếu hay bị kiệt sức,
	    Chúa hằng thành khẩn chăm nom,
	    chữa chạy khiến mau lành.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ác nhân thăm viếng con để dò xét,
	    Kháo đồn rằng bệnh nan y,
	    hết phương chữa chạy rồi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Biết bao thân hữu tin cậy ngày trước,
	    Đã từng một thuở chia cơm
	    cũng quay gót trở mặt.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Đoái thương nâng đỡ con dậy,
	    lạy Chúa, Chính Ngài phù trợ
	    cho con trả được mối hận này.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Chúa thương không để quân thù ngạo nghễ,
	    Bởi lòng này chẳng vương nhơ,
	    Chúa đặt trước nhan Ngài.
    }
  >>
  \set stanza = "ĐK:"
  Vì vậy con mới dám thưa:
  Xin thương tình chữa con, lạy Chúa,
  thực con đã lỗi phạm đến Ngài liên,
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2.5))
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
