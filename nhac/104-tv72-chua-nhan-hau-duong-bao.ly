% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Chúa Nhân Hậu Dường Bao" }
  composer = "Tv. 72"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  c16 (d) c8 g8. bf16 |
  c8 c a16 (c) a8 |
  g4 r8 g16 g |
  f8 f d e16 (d) |
  c2 |
  c8. d16 f8 g |
  e a r c |
  c (a16 g) d8 f |
  g2 ~ |
  g4 bf8 c |
  g8. bf16 d8 c |
  c2 ~ |
  c8 a g c |
  bf g4 e8 |
  f2 ~ |
  f8 \bar "||" \break
  
  c a' f |
  g8. f16 g8 bf |
  c2 ~ |
  c8 c
  \afterGrace a8 [({
    \override Flag.stroke-style = #"grace"
    g16)}
  \revert Flag.stroke-style
  f8] |
  g8. d16 d (f) e (d) |
  c2 ~ |
  c4 f8
  \afterGrace g8 ({
    \override Flag.stroke-style = #"grace"
    f16)}
  \revert Flag.stroke-style
  e8. f16 a (bf) a8 |
  g2 ~ |
  g8 bf bf b! |
  c4 c,8 c |
  g'4. a16 (g) |
  f2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  R2*15
  r8
  c a' f |
  g8. f16 e8 d |
  e2 ~ |
  e8 e f d |
  c8. b!16 b8 b |
  c2 ~ |
  c4 a8 [bf] |
  c8. c16 f (g) f8 |
  e2 ~ |
  e8 g g f |
  e4 c8 c |
  bf4. c8 |
  a2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Chúa nhân hậu dường bao với Ít -- ra -- en,
      Với những ai tâm hồn trong sạch.
      Vậy mà tôi như hụt bước, chút nữa bị trượt chân,
      Khi ganh tỵ với lũ kiêu căng,
      Khi nhìn ác nhân luôn thịnh đạt.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Chúng không hề gặp tai ương ở trong đời
	    Với tâm thần khỏe mạnh kiêu hùng,
	    mặc người ta bao cực khốn,
	    chúng hững hờ vô can,
	    Luôn đeo kiềng là thói kiêu căng,
	    Đem tàn ác điểm trang toàn thân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Chúng châm chọc và buông bao tiếng thâm độc,
	    Những tính toan mưu hại hung tàn,
	    miệng ngạo khinh cung trời nữa,
	    tấc lưỡi thực ba hoa,
	    Dân ta hùa theo chúng si mê,
	    Nên lòng chúng say sưa thỏa thuê.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Chúng nhủ rằng: làm sao Chúa thấu tỏ được,
	    Đấng Tối Cao đâu hiểu biết gì.
	    Bọn tàn hung như vậy đó, cứ mãi được an thân,
	    Riêng con này lại luống công sao,
	    Đêm ngày giữ đôi tay sạch tinh.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Tới khi được vào nơi thánh điện của Ngài
	    Mới thấu tri thân phận của họ,
	    Đặt vào nơi trơn trượt đó,
	    Chúa khiến họ tiêu vong,
	    Bao kinh hoàng xua hút tăm hơi,
	    Trong khoảnh khắc tiêu tan còn chi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
	    Chúa xua từ họ đi như thể cơn mơ
	    Đã biến tan khi tỉnh giấc nồng.
	    Này ruột gan con bỏng xót thấy trí mình ngu si,
	    Như trâu ngựa nào có hơn chi
	    Khi Ngài nắm tay con nào ngơi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Chúa khuyên dậy và luôn soi dẫn con đây
	    Tới chốn bao vinh hiển sáng ngời.
	    Còn tìm ai trên trời nữa,
	    dưới đất còn ham chi?
	    Cho thân này rồi có tiêu tan
	    Xin hằng náu nương nơi Ngài liên.
    }
  >>
  \set stanza = "ĐK:"
  Hạnh phúc của con là ở bên Chúa,
  Chốn con tựa nương đặt ở nơi Ngài,
  Ngay cửa vào thành thánh Si -- on,
  con xin loan báo mọi kỳ công của Ngài.
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
  system-system-spacing = #'((basic-distance . 0.1)
                             (padding . 3))
  page-count = 2
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
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #1.1
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
