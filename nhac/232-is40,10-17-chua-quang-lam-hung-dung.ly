% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Chúa Quang Lâm Hùng Dũng" }
  composer = "Is. 40,10-17"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4 c8 f |
  f8. e16 e8 d |
  a'4 \tuplet 3/2 { a8 f e } |
  d4. g8 |
  g2 ~ |
  g4 r8 g16 e |
  e4 \tuplet 3/2 { c'8 c d } |
  a4 r8 b16 g |
  g4 \tuplet 3/2 { d'8 d b } |
  c2 ~ |
  c4 \bar "||" \break
  
  e,8 d16 c |
  \slashedGrace { c16 ( } d8) e f d |
  g4. g16 c |
  b8 d e c |
  a2 ~ |
  a4 r8 a16 g |
  g8 a f e |
  d4. d16 \slashedGrace { d16 ( } e) |
  c8 c e16 (f) a8 |
  g2 ~ |
  g4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  \partial 4 c8 f |
  f8. e16 e8 d |
  f4 \tuplet 3/2 { f8 d c } |
  c4. c8 |
  b2 ~ |
  b4 r8 b16 b |
  c4 \tuplet 3/2 { e8 e g } |
  f4 r8 d16 d |
  e4 \tuplet 3/2 { f8 f g } |
  e2 ~ |
  e4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Kìa Đức Chúa quang lâm hùng dũng,
  nắm trọn chủ quyền trong tay,
  Bên cạnh Ngài, uy công lẫm liệt,
  Trước mặt Ngài, chiến tích lừng vang.
  <<
    {
      \set stanza = "1."
      Chưa như mục \markup { \italic \underline "tử" }
      chăn dắt đàn chiên,
      Tập trung lại dưới cánh tay Ngài.
      Lũ chiên con ấp ủ bên lòng,
      Bầy chiên mje tận tình đỡ nâng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Có ai lường \markup { \italic \underline "biển" }
	    trong vốc bàn tay,
	    Dùng gang mà đo chín cung trời,
	    Lấy thưng đong cát bụi trên đời,
	    Gom núi đồi đặt thử cán cân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Có ai cần \markup { \italic \underline "để" }
	    cho Chúa hỏi đâu,
	    Thần Khí Ngài ai biết đo lường,
	    Lấy ai tham vẫn để tinh tường,
	    Ai mách Ngài nẻo đường chính ngay.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Kiếm ai dạy \markup { \italic \underline "để" }
	    tri thức mở mang,
	    Ngàn dân tựa như nước miệng thùng,
	    Giống trên cân chút bụi bám lại,
	    Muôn \markup { \italic \underline "đảo" }
	    nặng tựa hạt cát thôi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Gỗ trên rừng Ly -- băng chẳng đủ thiêu,
	    Vật để làm hy lễ đâu vừa,
	    Trước Thiên Nhan hết mọi dân tộc,
	    Đâu đáng gì, huyền ảo, rỗng không.
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
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #0.6
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
