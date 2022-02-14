% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Con Là Thượng Tế" }
  composer = "Tv. 109"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 e8 |
  d4. c16 f |
  f4. 8 |
  d4 a'8 fs |
  g2 ~ |
  g4 r8 b16 c |
  a8 g g f |
  f4 \tuplet 3/2 { f8 g e } |
  d4. d16 g |
  b,8 b \tuplet 3/2 { b8 d c } |
  c4 r8 \bar "||" \break
  
  e |
  e e16 c c8 c |
  f4. d8 |
  g a4 g8 |
  e4 r8 e16 g |
  f8 d c c |
  a'4 a8 b |
  g8 a c c |
  \once \stemDown c4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r8 |
  R2*9
  r4.
  e8 |
  e e16 c c8 c |
  f4. d8 |
  b a4 b8 |
  c4 r8 c16 e |
  d8 b c c |
  f4 f8 d |
  e f <a f> <af f> |
  <g e>4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Sấm ngôn của Đức Chúa phán cùng Chúa thượng tôi:
      Bên hữu Cha, Con lên ngự trị
      để bao quân thù Cha sẽ đặt làm bệ dưới chân Con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chúa cho từ Si -- on vương quyền lớn rộng thêm
	    Đây giữa bao nhiêu quân địch thù xin hãy hiển trị,
	    xin lãnh quền mà xử xét muôn dân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Chính trong ngày đăng quang Con nhận chức quyền đây
	    Trong thánh thiêng cao sang rạng ngời,
	    hừng đông chưa dậy Cha đã từ lòng này tác sinh Con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chúa đang ngự phía hữu ở kề thánh thượng đây
	    Vương bá nay ra tay triệt hạ,
	    Bởi uống nước nguồn nên Chúa rầy ngẩng đầu cách hiên ngang.
    }
  >>
  \set stanza = "ĐK:"
  Đức Chúa đã một lần thề ước,
  Ngài luôn giữ y lời:
  Rằng muôn thuở con là Thượng Tế
  theo phẩm trật Mel -- ki -- sê -- đê.
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
    \override Lyrics.LyricSpace.minimum-distance = #1.2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
