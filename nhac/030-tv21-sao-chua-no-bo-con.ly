% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Sao Chúa Nỡ Bỏ Con"
  composer = "Tv. 21"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4.
  % thêm dấu nghỉ ẩn, vì nốt hoa mỹ ở đầu bản nhạc sẽ bị lỗi
  \once \hide r8
  \slashedGrace { c16 ( } d8) bf |
  a4 \slashedGrace { g16 ( } a8) f |
  e4 r8 e |
  a, \slashedGrace { f'16 ( } e4) cs8 |
  d4 r8 f16 f |
  e8 d g a |
  a4. bf16 bf |
  a8 g c d |
  d4 r8 d |
  d, e16 e f8 d |
  g4. g8 |
  g g16 e e8 g |
  a4 \slashedGrace { cs16 ( } d8) bf |
  a4 \slashedGrace { gs16 ( } a8) f |
  e4 r8 e |
  a \slashedGrace { f16 ( } e4) cs8 |
  c2 \bar "||"
  
  d8 e c d |
  a4 a8 f' |
  f8. d16 a' (bf) a8 |
  g4 r8 g16 f |
  g8 a g f |
  e4. e8 |
  e8. e16 a8 e |
  d4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Chúa con ơi, Chúa con ơi,
  sao Ngài nỡ bỏ con,
  Cứ đứng xa mà không tiếp cứu,
  Tiếng xiết rên Ngài không đoái tới.
  Suốt ngày than van Chúa chẳng nghe,
  Thâu đêm kêu cầu Ngài không đáp.
  Chúa con ơi, Chúa con ơi sao Ngài nỡ bỏ con.
  <<
    {
      \set stanza = "1."
      Nhưng Chúa ngự nơi đền
      là vinh quang của Is -- ra -- el
      Xưa tổ tiên vẫn trông cậy Ngài
      và Ngài từng độ trì.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Ngay lúc rời thai bào
	    Ngài trao tay mẹ ẵm thân con
	    Ngay từ khi mới sinh ra đời
	    đà được phụng hiến cho Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Khi tứ bề quân thù cùng xông lên
	    ùa đến vây con
	    Nghe mình như nước tan ra dần.
	    ruột mềm tựa sáp tơi bời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Xin Chúa đừng xa lìa
	    vì con trông nhờ Chúa luôn thôi
	    Xin giựt con thoát nanh muông rừng
	    khỏi miệng đàn chó điên khùng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Con sẽ thuật danh Ngài
	    để anh em từ khắp nơi hay
	    Trong ngày công nhóm
	    con dân Ngài hòa nhịp nhạc khúc ca tụng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
	    Ai kính sợ Chúa Trời cùng ca lên
	    mừng chúc uy danh
	    Chi tộc Gia -- cóp tôn vinh Ngài,
	    phục lạy nào Is -- ra -- el.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Tôi đã chịu ơn Ngài,
	    rầy nơi công hội sẽ ca khen
	    Bao lời đoan hứa xin vuông tròn
	    cận kề kẻ kính sợ Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "8."
	    Ai khó nghèo cơ cùng được no nê
	    và uống thỏa thuê
	    Ai tìm nhan thánh hãy ca tụng,
	    nguyện họ hạnh phúc muôn đời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "9."
	    Mau nhớ lại quay về nào con dân từ khắp nơi nơi
	    Muôn ngàn vương quốc trên gian trần
	    cùng phủ phục trước nhan Ngài.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 10\mm
  bottom-margin = 10\mm
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
  ragged-bottom = ##t
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
        \notBePhu -3 { \nhacPhienKhucAlto }
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
