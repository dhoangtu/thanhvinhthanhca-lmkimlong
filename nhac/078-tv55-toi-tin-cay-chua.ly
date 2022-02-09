% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Tôi Tin Cậy Chúa" }
  composer = "Tv. 55"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 a8 |
  e a gs (a) |
  b4. b8 ~ |
  b b a b |
  c2 |
  d8. d16 c8 d |
  e4. c8 ~ |
  c e d16 (c) g8 |
  a2 |
  b8. b16 a8 b |
  c4. a8 ~ |
  a c b16 (a) d,8 |
  e2 |
  c'4 a8 b ~ |
  b gs gs gs |
  a2 ~ |
  a4 r \bar "|." \break
  
  a8 a c16 (b) a8 |
  e4 r8 c16 c |
  d8 e c b |
  e4. e16 e |
  e8 e c' b |
  b4 r8 b |
  e8. e,16 b'8 c16 (b) |
  a2 ~ |
  a4 r8 \bar "||"
}

nhacPhienKhucAlto = \relative c'' {
  a8 |
  e a gs (a) |
  b4. d,8 ~ |
  d e f e |
  a2 |
  b8. b16 a8 b |
  c4. a8 ~ |
  a g f [e] |
  f2 |
  e8. e16 f8 e |
  a4. f8 ~ |
  f e d [b] |
  c2 |
  a'4 f8 d ~ |
  d e e e |
  c2 ~ |
  c4 r
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Trong ngày tôi sợ hãi,
  tôi tin cậy nơi Chúa.
  Tôi tin cậy nơi Chúa
  và tán dương lời Ngài.
  Tôi tin cậy nơi Chúa
  và hết lo sợ gì.
  Đố phàm nhân làm gì được tôi.
  <<
    {
      \set stanza = "1."
      Xin thương xót con cùng
      vì người ta tấn công chèn ép.
      Và ngày ngày dầy xéo thân con,
      lạy Chúa họ đông quá chừng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Bao nhiêu bước cơ cùng,
	    cầu Ngài ghi chép vào sổ sách,
	    Từng giọt lệ sầu đã tuôn rơi,
	    Ngài lấy vò, xin hứng vào.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Tôi kêu cứu lên Ngài,
	    địch thù xô lấn nhau chạy trốn,
	    Vì thực Ngài hằng ở bên tôi,
	    Lời Chúa miệng tôi tán tụng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Ôi Thiên Chúa con thờ,
	    lời thề xưa quyết tâm gìn giữ
	    Vfa trình Ngài của lễ tri ân
	    Ngài cứu mạng con thát nạn.
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
  page-count = 1
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
    \override Lyrics.LyricSpace.minimum-distance = #2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
