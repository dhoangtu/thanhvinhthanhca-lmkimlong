% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Xin Giấu Kỹ Con Đi"
  composer = "Tv. 63"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 d8 |
  bf'8. a16 \tuplet 3/2 { bf8 bf a } |
  g4 \tuplet 3/2 { bf8 c c } |
  d8. bf16 \tuplet 3/2 { c8 a a } |
  ef4. d16 d |
  g4 \tuplet 3/2 { a8 a g } |
  fs4. d8 |
  bf'8. a16 \tuplet 3/2 { bf8 bf a } |
  \partial 4 g4 \bar "||"
  
  \set Staff.printKeyCancellation = ##f
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \key g \major
  \partial 4 g8 a |
  b4. c16 (b) |
  a8 b4 c8 |
  d4 b8 d |
  c4. b8 |
  a2 |
  a8 fs g a |
  e4. d8 |
  a' a4 fs8 |
  g2 ~ |
  g4 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  r8 |
  R2*7
  r4
  
  \set Staff.printKeyCancellation = ##f
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \key g \major
  g8 fs |
  g4. e8 |
  fs g4 a8 |
  b4 g8 b |
  a4. g8 |
  fs2 |
  e8 d e d |
  c4. b8 |
  c d4 d8 |
  b2 ~ |
  b4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Nguyện Chúa nghe thấu tiếng con than,
      Giữ gìn mạng con khỏi quân thù đàn áp,
      Họ hùa nhau tác quái gây hại,
      Lạy Chúa xin giấu kỹ con đi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Mài lưỡi cho sắc bén nhue gươm,
	    Bắn từng loạt tên là bao lời hiểm ác,
	    Họ nhằm ai chất phác vô tội
	    Vụt bắn khi thấy vẫn vô can.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Bàn tính giăng bẫy rất tinh vi,
	    Chúng còn nhỏ to: nào ai người hòng thấy,
	    Họ bày ra chước quái mưu tà,
	    Người thế tâm trí ác gian thay.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Này Chúa cho phóng mũi tên bay,
	    Bắn tình lình nên bọn gian tà gục ngã,
	    Tàn mạng theo tấc lưỡi hư hoại,
	    Nhìn thế ai có xót thương chi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Vì thế nay khắp cõi nhân gian
	    Sẽ cùng truyền rao mọi công việc của Chúa,
	    Cùng hiểu ra cách Chúa xử sự,
	    Mừng rỡ trong Chúa mãi khôn ngơi.
    }
  >>
  \set stanza = "ĐK:"
  Người công chính sẽ mừng vui trong Chúa,
  tìm Chúa để nương mình.
  Tấm lòng ai chính trực đều lấy làm vinh.
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 10\mm
  right-margin = 10\mm
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
  \key bf \major \time 2/4
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
