% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Hãy Chúc Tụng Chúa Đi" }
  composer = "Tv. 146"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  a4 \tuplet 3/2 { a8 f a } |
  g4 \tuplet 3/2 { bf8 g g } |
  a4. e8 |
  e f4 g8 |
  c,4 \tuplet 3/2 { d8 c a' } |
  a4. f8 |
  bf g4 bf8 |
  bf4 r8 c, |
  g'4 \tuplet 3/2 { g8 e g } |
  f2 \bar "||"
  
  f4. e16 d |
  d4 \tuplet 3/2 { g8 g g } |
  g4 r8 bf16 a |
  a4. f8 |
  e4 \tuplet 3/2 { e8 g e } |
  d4 r8 d16 e |
  c4. d8 |
  f4 \tuplet 3/2 { e8 e g } |
  a4. bf16 bf |
  g4. c,8 |
  g' a4 g8 |
  f2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  f4 \tuplet 3/2 { f8 d f } |
  c4 \tuplet 3/2 { g'8 e e } |
  f4. c8 |
  cs d4 b!8 |
  c4 \tuplet 3/2 { bf8 a c } |
  f4. d8 |
  g e4 d8 |
  e4 r8 c |
  bf4 \tuplet 3/2 { c8 c bf } |
  a2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Hãy chúc tụng Chúa đi,
  thú vị dường bao được đàn ca kính Ngài.
  Thỏa tình biết mấy được tán tụng danh Chúa.
  Nào hãy chúc tụng Chúa đi.
  <<
    {
      \set stanza = "1."
      Chúa xây dựng lại Giê -- ru -- sa -- lem,
      Ít -- ra -- en tản lạc Ngài quy tụ về.
      Bao cõi lòng tan vỡ Ngài đà thuyên chữa,
      những vết thương Ngài băng bó cho lành.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chúa nay ngự duyệt tinh sao trên không,
	    xướng danh lên để gọi từng ngôi riêng biệt.
	    Ôi Chúa thực cao sáng, quyền lực vô đối,
	    trí thông minh thực tinh suốt khôn lường.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Chúa nâng người nghèo lên nơi cao sang,
	    Lũ gian mạnh nhận chìm tận đất đen rồi.
	    Cung sắt cầm dạo lên tụng mừng Thiên Chúa,
	    hãy xướng ca mà cảm mến ơn ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chúa che bầu trời cho mây giăng giăng,
	    Khiến mưa sa gội nhuần toàn cõi địa cầu.
	    Cho núi đồi tươi thắm, đẹp mầu hoa lá,
	    sẵn rau ngon để nhân thế hưởng dùng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Chúa không trọng vọng đội chân lanh chai,
	    Vó câu phi vội vàng Ngài chẳng ưa gì.
	    Nhưng mến chuộng ai vẫn trọn niềm tin kính,
	    vững trông nơi tình thương mến của Ngài.
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
    \override Lyrics.LyricSpace.minimum-distance = #0.6
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
