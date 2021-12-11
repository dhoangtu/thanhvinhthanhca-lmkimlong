% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Tán Dương Kỳ Công Chúa"
  composer = "Tv. 65"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4 d8 d |
  d8. c16 a8 a |
  b4 b8 a16 (g) |
  e8. g16 a8 e |
  d4 r8 a |
  d8. e16 g8 b |
  a8. a16 c8 c |
  d2 ~ |
  d8 b d b16 (a) |
  fs4. fs8 |
  g8 fs g a |
  d,2 ~ |
  d4 a8 a |
  d4 fs8 (g) |
  a8. d16 b8 a |
  d,8. d'16 b (a) fs8 |
  
  \time 3/4
  g2 \bar "||"
  
  b8 b |
  b4. fs8 a fs |
  d2 d8 d |
  a'4. gs8 a b |
  c2 a8 a |
  d4. c8 a d |
  fs,2 fs8 e |
  d4. a'8 fs4 |
  g2 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  r4 |
  R2*15
  
  \time 3/4
  r2
  g8 g |
  g4. d8 cs cs |
  d2 d8 d |
  cs4. e8 fs g |
  a2 g8 g |
  fs4. fs8 fs e |
  d2 d8 c |
  b4. c8 d4 |
  b2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Khắp trái đất hãy tung hô Chúa,
      Hát lên mừng Danh Thánh rạng ngời,
      Họa đàn ngợi khen chúc vinh
      và thân thưa Chúa,
      Ôi đáng kinh sợ vì bao kỳ công Chúa làm,
      Quyền lực Ngài vô biên
      khiến cho quân thù cũng phải phục suy.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Chính Chúa khiển biển thành đồng khô,
	    Khiến dân Người đi giữa sông ngòi,
	    Việc Ngài làm đã khiến ta mừng vui chan chứa,
	    Cho đến muôn đời Ngài luôn hiển vinh thống trị,
	    Nhìn tận tường mọi dân,
	    khiến quân phản nghịch chớ mong vùng lên.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Các nước hỡi hãy tung hô Chúa,
	    Cất cao lời ca tán dương Ngài,
	    Vì Ngài bảo vệ chúng ta khỏi lo xiêu té.
	    Vâng Chúa đã từng dò xem và thử thách hoài.
	    Ngài luyện lọc đoàn con
	    cũng như luyện bạc ở trong lò thôi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Chúa đã chất ghánh đè nặng vai,
	    Để rơi vào cạm bẫy quân thù,
	    Và để phàm nhân cỡi lên đầu con dân Chúa,
	    Xô chúng con vào từng cơn lửa thiêu, nước lụt,
	    Rồi Ngài lại dủ thương,
	    cứu lên đưa vào chốn bao thảnh thơi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Tiến đến với lễ vật toàn thiêu,
	    Bước chân vào nơi thánh cung Ngài,
	    Một lòng gìn giữ tín trung lời con tuyên khấn,
	    Bao tiếng đoàn thề mà môi này đã phát nguyền,
	    Vào hồi gặp hiểm nguy,
	    lưỡi con không ngừng nhắc nhở lại liên.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
	    Kính tiến Chúa lễ vật toàn thiêu,
	    Với chiên bò thơm ngát hương nồng,
	    Nào người trọn niềm kính tin lại nghe tôi nói,
	    Bao những công việc Ngài thương vì tôi đã làm,
	    Vừa mở miệng là tôi
	    những luôn sẵn sàng tán dương chẳng ngơi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Nếu ác ý nhiễm vào lòng tôi,
	    Chắc hẳn Người không đoái nhậm lời,
	    Vậy mà Ngài đã lắng nghe lời tôi kêu khấn.
	    Xin tán dương Ngài đà không từ nan đáp lời,
	    Và trọn đời
	    Ngài không dứt nghĩa đoạn tình với tâm hồn tôi.
    }
  >>
  \set stanza = "ĐK:"
  Khắp trái đất phục bái tôn thờ,
  cùng đàn ca mừng tôn danh Chúa.
  Lại mà xem công việc Chúa làm,
  Đáng kinh sợ giữa phàm nhân.
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 15\mm
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
  system-system-spacing = #'((basic-distance . 0.1)
                             (padding . 3))
  ragged-bottom = ##t
}

TongNhip = {
  \key g \major \time 2/4
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
