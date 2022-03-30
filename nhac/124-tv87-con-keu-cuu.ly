% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Con Kêu Cứu" }
  composer = "Tv. 87"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 e8 |
  c'4. c16 a |
  b4 r8 d16 d |
  c4. c8 |
  b c4 d8 |
  e2 ~ |
  e4 d8. d16 |
  c8 d e c |
  b2 ~ |
  b4 b8. b16 |
  c8 e, b' b16 (e) |
  a,2 ~ |
  a4 r8 \bar "||" \break
  
  e |
  a8. a16 f8 e |
  d4. d16 f |
  e (d) b8 d e |
  e4 r8 a |
  a8. a16 b8 a |
  gs4 r8 e16 e |
  c'8 b gs (e) |
  a4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  e8 |
  a4. a16 f |
  e4 r8 b'16 b |
  a4. a8 |
  gs a4 b8 |
  c2 ~ |
  c4 b8. b16 |
  a8 b gs a |
  e2 ~ |
  e4 e8. d16 |
  c8 c e [gs] |
  a2 ~ |
  a4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Lạy Chúa cứu độ con,
  trước thánh Nhan đêm ngày con kêu cứu,
  Mong cho lời kinh thấu tới Ngài,
  Xin nghe tiếng lòng con khấn nài.
  <<
    {
      \set stanza = "1."
      Hồn con đau khổ trăm chiều,
      Mạng sống con kề bên cõi chết,
      Thân con như đã trong mồ,
      thực kiệt sức đâu còn chi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Nằm đây giữa bao thi hài,
	    Tựa xác trong mồ sâu giấu kín,
	    Thân con nay Chúa quên rồi,
	    Ngài đà dứt khỏi bàn tay.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Dìm xuống hố thẳm mịt mùng,
	    Ngài để con ngợp trong bóng tối,
	    Trên con xô trút cơn giận
	    tựa triều sóng phủ ngập con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ngài khiến những kẻ thân tình
	    Tởm gớm con và lo né tránh,
	    Con mong chi thoát ra được
	    và cặp mắt lu mờ đi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Này con kêu khẩn đêm ngày,
	    Và cánh tay hằng vươn tới Chúa,
	    Thây ma đâu hát khen Ngài,
	    từ lòng đất ai tụng ca.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Từ cõi chết, nơi mộ phần
	    Nào có ai kể ân nghĩa Chúa,
	    Bao uy công Chúa ai tường,
	    lòng thành tín ai người hay.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Phần con luôn khẩn xin Ngài,
	    Hừng sáng con chờ ra mắt Chúa,
	    Nhân sao xua chối con hoài,
	    và Ngài cứ ẩn mặt đi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "8."
      \override Lyrics.LyricText.font-shape = #'italic
	    Từ thơ nhi đã cơ cùng,
	    Ngài khiến con ngẩn ngơ khiếp hãi,
	    Gieo thêm bao nỗi kinh hoàng,
	    thịnh nộ Chúa phủ ngập con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "9."
	    Ngần ấy thứ bủa vây hoài,
	    Vùi lấp như ngàn cơn sóng biếc,
	    Bao thân nhân cũng xa lìa,
	    chỉ con bóng đêm phủ che.
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
