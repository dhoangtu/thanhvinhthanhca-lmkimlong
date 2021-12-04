% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Xin Chúa Thương Con"
  composer = "Tv. 50"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 d8 |
  a'4. a16 a |
  a4. g8 |
  f f4 g8 |
  e4 \tuplet 3/2 { a8 d, d } |
  g4. g8 |
  f4 f8 g |
  a2 ~ |
  a4 r8 a16 g |
  a4 \tuplet 3/2 { f8 g a } |
  e4 r8 g16 f |
  g4 \tuplet 3/2 { a8 e f } |
  d2 \bar "||"
  
  \set Staff.printKeyCancellation = ##f
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \key d \major
  a'8. a16 a8 fs |
  g4. b8 |
  a g4 fs8 |
  e2 |
  e8 fs16 (e) d8 d |
  a'4. fs8 |
  g e4 e8 |
  d2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r8 |
  R2*12
  
  \set Staff.printKeyCancellation = ##f
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \key d \major
  fs8. fs16 fs8 d |
  e4. g8 |
  fs e4 d8 |
  cs2 |
  cs8 d16 (cs) b8 b |
  cs4. d8 |
  e cs4 cs8 |
  d2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Lạy Chúa xin thương con như lòng Ngài nhân hậu
      Xóa bỏ tội con theo lượng từ bi Chúa,
      Xin rửa con sạch lâng vết tội,
      Thanh tẩy con hết mọi lỗi lầm.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Lạy Chúa con đâu quên bao tội tình con phạm,
	    Hết mọi tiền khiên ám ảnh từng giây phút,
	    trước nhan Chúa thực con đắc tội,
	    Không từ nan xúc phạm đến Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Thực Chúa luôn công minh phân xử
	    chẳng thiên vị,
	    Rất mực thẳng ngay mỗi khi Ngài tuyên án.
	    Khi vừa sinh là con mắc tội,
	    Trong bào thai đã mang lỗi lầm.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Ngài muốn trong tâm can con người hằng chân thật,
	    Hãy chỉ dạy con cư xử thật khôn khéo.
	    Xin rẩy nước và thương xá tội,
	    Xin rửa con trắng tựa tuyết trời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Lạy Chúa xin quay đi, thôi nhìn mà quy tội,
	    Hãy tẩy rửa con cho sạch mọi gian ác,
	    Cho lòng con trở nên trắng ngần,
	    Xin tặng ban khí lực mới vào.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
	    Đừng nỡ xua con đi xa khỏi thần nhan Ngài,
	    Chớ từ lòng con cất đi thần linh Chúa,
	    Ban lại con nguồn vui cứu độ,
	    Bang trợ con với lòng quảng đại.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Đường Chúa con xin đem rặn dạy phường ngỗ nghịch,
	    thúc giục tội nhân trở lại cùng Thiên Chúa.
	    Xin Ngài tha nợ vương máu đào.
	    Cho miệng con hớn hở hát mừng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "8."
	    Lạy Chúa con reo vui ca tụng Ngài công bình,
	    Hãy mở miệng con vang lời ngợi khen Chúa,
	    Chúa đâu có màng chi lễ vật
	    Dâng toàn thiêu cũng chẳng đoái hoài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "9."
	    Lạy Chúa con xin dâng tâm hồn này khiêm hạ,
	    Hối hận sầu đau mong Ngài đừng chê chối.
	    Xin rộng ban ngàn muôn phúc lộc,
	    Xin trùng tu lũy thành điêu tàn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "10."
	    Ngày ấy Chúa ghé mắt vui nhận từng lễ vật,
	    Lễ vật toàn thiêu thiên hạ cũng dâng tiến:
	    Đây bò tơ đặt trên tế đàn
	    hương tỏa bay thấu tận cõi trời.
    }
  >>
  \set stanza = "ĐK:"
  Xin cho con được nghe tiếng hoan hỉ reo mừng,
  Xương cốt Ngài nghiền nát nay xướng ca tưng bừng.
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
  page-count = 2
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
