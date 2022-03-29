% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Xin Đừng Bỏ Mặc Con" }
  composer = "Tv. 37"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4 d8 d |
  a'4. f8 |
  d a d (f) |
  g2 |
  bf8. g16 d'8 bf |
  a4. a8 |
  bf a d e |
  e4 r8 a, |
  f'4 e8 cs |
  d2 ~ |
  d4 \bar "||" \break
  
  a8 bf |
  bf8. g16 f8 a |
  e4 f8 c |
  d8. g16 e8 e16 (f) |
  a2 ~ |
  a8 d bf g |
  a a16 g f8 a |
  e4 a8 bf |
  a a16 a d8 e |
  d2 ~ |
  d4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  d8 d |
  a'4. f8 |
  d a d (f) |
  g2 |
  g8. e16 f8 g |
  f4. f8 |
  g f bf g |
  a4 r8 a |
  d4 g,8 a |
  f2 ~ |
  f4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Vạn lạy Chúa, xin đừng bỏ mặc con.
  Xin đừng nỡ xa con,
  Cầu mong Ngài mau đến giúp,
  lạy Chúa cứu độ con
  <<
    {
      \set stanza = "1."
      Khi trách mắng xin đừng phẫn nộ,
      lúc sửa trị xin đừng giận dữ,
      Ấy cả mình con mũi tên Ngài cắm ngập,
      Bàn tay Ngai đè nặng trĩu thân con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Xương gẫy nát, da thịt tím bầm,
	    bởi tội tình con phạm chồng chất,
	    Gánh tội nặng vai vết thương càng nức mùi,
	    Ngày lại ngày tàn lực mãi tiêu tan.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Lưng nóng cháy như lửa chất đầy,
	    tấm hình hài tiêu điều ủ rũ,
	    Sức đã tàn suy khắp thân mình nát nhừ,
	    Miệng thét gào vì lòng xốn xang luôn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Bao ước muốn mong Ngài thấu tỏ,
	    tiếng khẩn nài sao Ngài chẳng rõ?
	    Mắt đã mờ đi, trái tim càng bấn loạn,
	    Người thân tình nào còn thấy ai đâu.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Quân quái ác giăng bủa lưới dò,
	    lưỡi độc địa buông lời phỉ báng.
	    Suốt cả ngày con vẫn không hề hé miệng,
	    Và tai này cầm bằng điếc không nghe.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Con tín thác trông cậy Chúa hoài,
	    khấn nguyện Ngài ban lời trả đáp,
	    Chớ để thù nhân cứ lên mặt diễu cợt,
	    Dù thân này vì tội lỗi sa cơ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Quân oán ghét con thực quá nhiều,
	    lũ địch thù con thực mạnh thế.
	    Đáp trả ngàn ơn chúng gây chuyện oán thù,
	    Họ tố tụng vì điều tốt con theo.
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
    \override Lyrics.LyricSpace.minimum-distance = #2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
