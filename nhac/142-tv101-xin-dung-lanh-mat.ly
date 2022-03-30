% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Xin Đừng Lánh Mặt" }
  composer = "Tv. 101"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \autoPageBreaksOff
  a8 f d g |
  g4 r8 g |
  f4. f16 a |
  e2 |
  e8 d g g |
  a4 r8 a16 bf |
  a8 e g16 g a8 |
  f2 \bar "||"
  
  d8. f16 c8 a |
  d4. f16 e |
  e8 d16 (e) g8 a |
  a4 r8 d |
  g,8. g16 a8 a |
  
  \pageBreak
  
  bf4. g8 |
  a8. a16 f (e) c8 |
  d2 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  a8 f d g |
  g4 r8 e |
  d4. d16 d |
  c2 |
  e8 d g g |
  a4 r8 f16 g |
  f8 a, e'16 e cs8 |
  f2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Lúc con gặp gian truân,
  xin Ngài đừng lánh mặt.
  Trong ngày con kêu cứu,
  xin lắng nghe và mau mau đáp lời.
  <<
    {
      \set stanza = "1."
      Xin Chúa nhậm lời con,
      tiếng con kêu vọng lên tới Chúa,
      Tháng ngày đời tan ra khói
      Xương cốt cháy tựa hỏa lò.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Đâu thiết chi của ăn,
	    trái tim như cỏ khô héo hắt,
	    Suốt ngày miệng con rên xiết,
	    Thân xác ấy xương bọc da.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Như cú vọ rừng hoang,
	    khác chi đâu bồ nông đất vắng,
	    Trí lòng tàn canh thao thức
	    Như những cánh chim lạc đàn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Bao ác nhân cười chê,
	    chúng điên lên rủa con nát nước,
	    Bánh độ nhật đây tro trấu,
	    Con uống suối lệ hòa chan.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Khi Chúa giận sục sôi,
	    nhắc con lên rồi xô sấp xuống,
	    Tháng ngày đời con nghiêng bóng,
	    Thân héo úa như cỏ khô.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Nhưng Chúa hiển trị luôn,
	    khắp nhân gian còn luôn nhắc nhớ,
	    Chúa nhìn phận Si -- on đó,
	    Thương xót đứng lên độ trì.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Tôi tớ của Ngài đây
	    xót xa trông thành xưa phế tích,
	    Bấy giờ ngàn dân tôn kính,
	    Vua chúa đến suy phục Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "8."
      \override Lyrics.LyricText.font-shape = #'italic
	    Xin tái tạo thành đô,
	    để Si -- on rực quang ánh Chúa,
	    Tiếng người lầm than kêu khấn
	    Nay Chúa đoái thương thẩm nhận.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "9."
	    Nơi thánh điện, tòa cao,
	    cõi thiên cung Ngài trông xuống thế,
	    Đáp lời tù nhân rên xiết,
	    Ân xá kẻ bị tử hình.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "10."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ai nấy nay ngợi khen,
	    khắp Si -- on rền câu kính chúc,
	    Kết lời cùng muôn dân nước
	    Nô nức đến suy phục Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "11."
	    Ôi Chúa Trời của con,
	    cắt ngang chi đời con giữa kiếp,
	    Chúa vạn đại luôn kiên vững,
	    Sao nỡ rút tuổi thọ con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "12."
      \override Lyrics.LyricText.font-shape = #'italic
	    Xưa Chúa dựng trời cao,
	    trước khi xây nền cho đất thấp,
	    Dẫu vạn vật luôn thay biến,
	    Muôn kiếp Chúa không chuyển rời.
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
