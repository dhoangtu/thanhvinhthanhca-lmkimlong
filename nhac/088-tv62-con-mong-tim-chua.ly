% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Con Mong Tìm Chúa"
  composer = "Tv. 62"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4 a8 g16 g |
  a8 a a e |
  c'2 |
  r8 c c d |
  e8. e16 d8 c |
  b2 ~ |
  b4 r8 a16 g!? |
  a8 a a b |
  c2 |
  r8 b c b16 (a) |
  gs8. e16 f8 e |
  a2 ~ |
  a4 r8 \bar "||"
  
  c |
  b4 a8 b16 (a) |
  gs8. gs16 a8 b |
  e,4 r8 e |
  e'8. c16 a8 a ~ |
  a b c16 (b) a8 |
  b2 |
  g!?8. a16 e8 e ~ |
  e c' b a |
  e'4 d8 d |
  d4. b8 |
  e8. e16 c8 b |
  a4 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  a8 g16 g |
  a8 a a e |
  a2 |
  r8 a a b |
  c8. c16 b8 a |
  e2 ~ |
  e4 r8 a16 g!? |
  a8 g f e |
  a2 |
  r8 gs a [d,] |
  e8. c16 d8 d |
  c2 ~ |
  c4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Ngay từ rạng đông con mong tìm Chúa,
  Ngài là Thiên Chúa, đấng con tôn thờ.
  Linh hồn con luôn khao khát Chúa,
  Thân xác con này mòn mỏi đợi trông.
  <<
    {
      \set stanza = "1."
      Tiến lên chiêm ngưỡng Ngài từ nơi thánh điện
      Để thấy cho tận tường vinh hiển quyền năng
      Vì ân tình Ngài quí hơn mạng sống,
      Môi miệng con nguyện mãi tán dương ca mừng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Thế nên con ước nguyện tụng ca suốt đời,
	    Và chắp tay nguyện cầu Danh Chúa quyền linh,
	    Được no đầy tựa mới dự tiệc yến,
	    Trên làn môi rộn rã khúc ca ân tình.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Mỗi khi lên tới giường là con nhớ Ngài,
	    Là suốt đêm bồi hồi thao thức nào ngơi,
	    Vì con được Ngài đoái thương trợ giúp,
	    Bao mừng vui ẩn náu mãi ở nơi Ngài.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 5\mm
  bottom-margin = 5\mm
  left-margin = 10\mm
  right-margin = 10\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  %page-count = #1
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
        \notBePhu -3 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #0.8
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
