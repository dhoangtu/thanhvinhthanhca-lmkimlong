% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Đấng Tôi Ca Ngợi" }
  composer = "Xh. 15,1-18"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  g8 g f16 (g) d8 |
  bf'4. d8 ~ |
  d c bf16 (c) bf8 |
  a2 |
  f8 g16 (f) d8 bf' |
  bf4. a8 ~ |
  a c d f, |
  g2 \bar "||"
  
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \set Staff.printKeyCancellation = ##f
  \key g \major
  b8. g16 c8 b |
  a fs r fs |
  b e,4 g8 |
  a4. b8 |
  g8. c16 c8 a |
  b2 |
  b8. g16 c8 b |
  a fs r fs |
  b e,4 g8 |
  a4. b8 |
  b8. b16 a8 d |
  g,2 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  R2*8
  
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \set Staff.printKeyCancellation = ##f
  \key g \major
  g8. e16 a8 g |
  c, d r d |
  g c,4 r8 |
  d4. g8 |
  e8. e16 a8 fs |
  g2 |
  g8. e16 a8 g |
  c, d r d |
  g c,4 e8 |
  d4. g8 |
  g8. g16 fs8 fs |
  g2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Tôi xin hát mừng Chúa,
      Đấng cao cả uy hùng
      Kỵ binh cùng chiến mã,
      Ngài xô xuống đại dương.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Bao xa mã cùng với
	    tướng binh của Ai Cập
	    Ngài xô chìm đáy nước
	    Biển Đỏ lấp vùi luôn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Trong cơn nghĩa nộ Chúa,
	    nước đang chảy ngưng lại
	    Trung dương dồn sóng biếc
	    Dựng như bức tường ngăn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Đây bao kẻ thù nói:
	    chúng ta đuổi theo họ
	    Dùng gươm trần giết hết
	    Và chia chiến phẩm đi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Phong ba bỗn dồn tới,
	    Chúa xô biển chôn vùi
	    Họ chư chì rớt xuống,
	    Chìm sâu dưới đại dương.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ai trong các thần thánh
	    sánh chi nổi như Ngài
	    Thực oai hùng, chí thánh,
	    Làm khôn xiết kỳ công.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Giơ tay hữu Ngài
	    khiến đất rẽ để nuốt họ
	    Còn dân Ngài cứu thoát
	    Được thương mến chở che.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "8."
      \override Lyrics.LyricText.font-shape = #'italic
	    Đưa dân tới miền đất
	    thắm nương cỏ xanh rì
	    Và đem về núi thánh
	    Là nơi Chúa dành riêng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "9."
	    Nơi đây có đền thánh Chúa
	    ta đã xây dựng
	    Và muôn đời chính Chúa
	    Là vua thống trị luôn.
    }
  >>
  \set stanza = "ĐK:"
  Chúa là Đấng tôi ca ngợi,
  là sức mạnh của tôi,
  chính Ngài đã cứu độ tôi.
  Chúa là Đấng tôi tôn thờ,
  là Chúa tổ tiên tôi,
  xin dâng muôn lời tán tụng.
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
  \key bf \major \time 2/4
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
