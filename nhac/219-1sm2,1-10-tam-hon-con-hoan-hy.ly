% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Tâm Hồn Con Hoan Hỷ" }
  composer = "1Sm. 2,1-10"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4 g8 d |
  g g
  \afterGrace fs8 ({
    \override Flag.stroke-style = #"grace"
    g16)}
  \revert Flag.stroke-style
  a8 |
  b4 r8 g |
  g b16 c a8 c |
  d4 r8 c |
  c c e d16 (c) |
  a4 fs8. fs16 |
  e8 e a d, |
  g2 \bar "||" \break
  
  e8. fs16 fs8 fs |
  d e4 g16 (a) |
  b4 r8 e |
  a, (c4) e8 |
  d4 \slashedGrace { b16 ( } d8) b16 (a) |
  g2 |
  a8. a16 b8 e, ~ |
  e g b d |
  a4 r8 e |
  e e r d |
  a'4. fs8 |
  g4 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  g8 d |
  g e d [d] |
  g4 r8 f! |
  e g16 e fs8 a |
  fs4 r8 a |
  a a g [g] |
  fs4 d8. d16 |
  cs8 cs c! c |
  b2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Tâm hồn con hoan hỷ trong Chúa,
  Nhờ Ngài con ngẩng đầu hiên ngang,
  mở miệng nhạo báng quân thù,
  Hân hoan vì Ngài cứu độ con.
  <<
    {
      \set stanza = "1."
      Không có đấng thánh nào được như Chúa,
      cũng chẳng có ai giống như Ngài.
      Ai đâu dũng mạnh bằng Thiên Chúa đây
      Ngoại trừ Ngài nào thấy một ai.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Ngươi chớ có lắm lời mà vênh váo,
	    cũng đừng thốt ra tiếng khinh mạn,
	    Bao nhiêu tác động Ngài luôn quán thông,
	    Một mình Ngài xử xét thẳng ngay.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Ai yếu đuối sẽ trở nên mạnh mẽ,
	    chiếc nỏ dũng nhân gẫy tan tành,
	    Cho ai khó nghèo được thư thái luôn,
	    Còn người giầu làm mướn độ thân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Ai trễ hiếm sẽ hạ sinh con cái,
	    những mẹ lắm con bỗng suy tàn,
	    Cho sinh thác là ở tay Chúa thôi.
	    Ngài nhận chìm rồi kéo trổi cao.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Tay Chúa nhấn xuống rồi giựt lên đó,
	    khiến kẻ phú vinh, kẻ đơn nghèo,
	    Nâng ai thấp hèn khỏi nơi đất đem
	    Và người nghèo khỏi chốn bẩn nhơ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
	    Ngai chói sáng Chúa tặng làm sở hữu,
	    khiến họ sánh vai với vương hầu,
	    Trông coi móng nền của trái đất liên,
	    Ngài đặt trọn hoàn vũ ở trên.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Luôn giữ lối bước của người trung hiếu,
	    khiến bọn ác nhân phải lu mờ,
	    Tiêu tan khuất dạng vì nơi thế nhân
	    Nào nhờ mạnh mà thắng hoài đâu.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "8."
	    Tung sấm sét đánh kẻ thù tan tác,
	    Chúa xử xét luôn cõi gian trần,
	    Nâng cao thế lực Vị vua Chúa phong
	    Và vị được Ngài xức dầu cho.
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
  page-count = #1
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
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #0.4
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
