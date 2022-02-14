% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Vì Nhiệt Tâm Lo Nhà Chúa" }
  composer = "Tv. 68"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4 a8 a |
  c4. c8 b b |
  e2 c8 d |
  d4. c8 a a |
  b2. |
  a4. f8 a f |
  e2 e4 |
  c'4. b8 b e |
  a,2 \bar "||" \break
  
  a8. b16 |
  \time 2/4
  b8 gs4 e8 |
  c'4. b8 |
  d8. e16 c (b) e8 |
  \slashedGrace { a,8 ( } b2) |
  a8. gs16 b8 a ~ |
  a a g d |
  e4 r8 e |
  c'8 c16 a d8 d |
  e2 ~ |
  e4 d8 c |
  c8. e16 a,8 c |
  b b ~ b4 ~ |
  b4 b8 gs |
  gs8. e16 b'8 b |
  a a ~ a4 ~ |
  a \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  a8 f |
  e4. e8 e e |
  c'2 a8 g |
  f4. a8 f f |
  e2. |
  f4. d8 f d |
  c2 c4 |
  a'4. a8 gs gs |
  a2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Vì nhiệt tâm lo việc nhà Chúa
  mà con đây phải thiệt vào thân.
  Bao lời thóa mạ Ngài này chính thân con hứng chịu
  <<
    {
      \set stanza = "1."
      Xin cứu vớt con.
      lạy Chúa vì nước đã lên tới cổ.
      Con bị lún sâu xuống nơi sình lầy,
      Nào biết đứng vào đâu cho vững,
      Thân chìm ngập giữa dòng nước bao la
      Sóng dập dồn từng lớp cuốn trôi xa.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Kêu thống thiết nên kiệt sức
	    và đã ráo khô cuống họng,
	    Trông đợi Chúa luôn mắt con mỏi mòn,
	    Bè lũ oán thù con vô cớ
	    Ôi thực nhiều gấp bội tóc con đây,
	    Chúng bạo tàn lại thắng thế hơn con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Con giấu diếm chi được Chúa
	    lầm lỗi chính con trót phạm,
	    Nhưng nguyện Chúa thương chớ để vì con
	    Mà khiến những người trông mong Chúa
	    Mang thẹn thùng xấu hổ với chư dân,
	    Nờ lòng nào, lạy Chúa Ít -- ra -- en.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Âu cũng chính bởi tại Chúa,
	    từng lũ nhắm con thoá mạ,
	    Cam chịu nhuốc nhơ phủ che mặt mày,
	    Người thân lơ là như không biết
	    Con một mẹ cũng hờ hững trông qua,
	    Ngó ruột thịt bằng nước lã hơn chi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Thân héo hắt bởi nhịn đói
	    thành cớ thế nhân chế nhạo
	    Con mặc áo xô chúng lại cười chê,
	    Bọn rỗi rãi ngồi lê đôi mách,
	    Quân bợm rượu cũng đàm tiếu khinh khi,
	    Khấn nguyện Ngài hãy đáp tiếng kêu than.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Xin cứu thoát con lạy Chúa
	    khỏi lún mãi trong vũng lầy
	    Khỏi vực nước sâu, khỏi tay địch thù,
	    Nguyện Chúa đáp lời con kêu khấn,
	    Theo lòng Ngài vẫn từ ái bao la,
	    Đoái nhìn lại mà giáng phúc thi ân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Xin chớ lánh mặt, lạy Chúa,
	    nguyện đáp tiếng con nức nở,
	    Xin Ngài đến bên xuống tay hộ phù,
	    Này lúc số mạng con nguy khốn,
	    Con thẹn thùng chấp nhận những khinh khi
	    Lũ địch thù Ngài thấy rõ quanh con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "8."
      \override Lyrics.LyricText.font-shape = #'italic
	    Tim vỡ nát, thân rời rã
	    vì hứng lấy bao thóa mạ,
	    Trông người xớt chia vẫn chẳng gặp ai,
	    Đợi mãi tiếng ủi an đâu thấy,
	    Lương thực trộn thuốc độc bắt con ăn,
	    Khát thì họ tặng chút dấm chua cay.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "9."
	    Xin cứu vớt con, lạy Chúa,
	    phận kiếp đớn đau khốn khổ,
	    Con sẽ hát ca thánh danh của Ngài,
	    Và cất tiếng tạ ơn khôn ngớt,
	    Hơn là thượng tiến bò béo, bê tơ,
	    Tiếng ngợi mừng đẹp ý Chúa trăm muôn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "10."
      \override Lyrics.LyricText.font-shape = #'italic
	    Nghe thế hãy mau mừng rỡ,
	    nào hết những ai khó nghèo,
	    Mau cùng sướng vui những ai tìm Ngài,
	    Ngài đáp tiếng bần nhân kêu khấn,
	    Thân tù đầy Chúa nào có coi khinh,
	    Đất trời nào cùng cất tiếng tôn vinh.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2.5))
  ragged-bottom = ##t
}

TongNhip = {
  \key c \major \time 3/4
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
