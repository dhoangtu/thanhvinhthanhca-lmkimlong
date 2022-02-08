% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Hãy Reo Hò Mừng Chúa" }
  composer = "Tv. 32"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4 f8 g |
  a4. bf8 |
  a g4 g8 |
  c2 ~ |
  c4 bf8 a |
  g4. g8 |
  c c4 e,8 |
  f2 ~ |
  f4 r |
  f8. e16 f8 c |
  d2 |
  f4 g |
  a2 |
  bf8. a16 a8 g |
  c2 |
  d4 bf |
  g2 |
  a8. a16 f8 d |
  d2 |
  c8 f4 g8 |
  a2 |
  f8. f16 bf8 a |
  g2 |
  c8 e,4 g8 |
  f2 \bar "|." \break
  
  f4 f8 (g) |
  a2 |
  f8 f g (f) |
  d2 |
  d4 f |
  c2 |
  g'8 g e4 |
  f2 |
  bf4. a8 |
  g4. g8 |
  c c4 d16 (c) |
  a2 |
  bf4. g8 |
  e4. c8 |
  c g'4 g8 |
  f4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  f8 g |
  a4. g8 |
  f e4 d8 |
  e2 ~ |
  e4 bf'8 a |
  g4. f8 |
  e e4 c8 |
  a2 ~ |
  a4 r |
  f'8. e16 f8 c |
  d2 |
  a4 c |
  f2 |
  bf8. a16 a8 g |
  c2 |
  bf8 (a) g (f) |
  e2 |
  a8. a16 f8 d |
  d2 |
  c8 a4 c8 |
  f2 |
  f8. f16 bf8 a |
  g2 |
  f8 c4 bf8 |
  a2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Người công chính hãy reo hò mừng Chúa,
  Kẻ ngay lành nào cất tiếng ngợi khen.
  Gieo vạn tiếng huyền cầm tạ ơn Chúa,
  Nảy muôn cung đàn sắt tán tụng Ngài.
  Hãy hát lên mừng Ngài một bài ca mới,
  Cùng rập tiếng reo vui tấu nhạc vang trời.
  <<
    {
      \set stanza = "1."
      Vì lời Chúa là lời chân thực
      việc Chúa làm rất đáng cậy tin.
      Chúa yêu chuộng điều công minh chính trực,
      Phúc ân Ngài tràn ngập khắp thế gian.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Một lời Chúa tạo dựng cung trời,
	    \markup { \italic \underline "hơi" }
	    thở Ngài thắp sáng ngàn sao.
	    Chúa tho dồn đại dương theo ý định.
	    Khắp gian trần đều phục bái khiếp kinh.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Lời Người phán mọi vật xuất hiện,
	    lệnh Chúa truyền khiến có càn khôn.
	    Chúa đảo lộn điều chư dân ước định,
	    Phá tan tành mọi dự định thế nhân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Từ thượng giới Ngài nhìn thế trần,
	    từ cõi trời thấy rõ phàm nhân,
	    chính tay Ngài dựng nên muôn cõi lòng,
	    Mãi am tường mọi việc chúng tính toan.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Thật hạnh phúc được làm dân Ngài,
	    làm sản nghiệp Chúa đã chọn riêng,
	    Ý định Ngài ngàn năm luôn vững bền,
	    Những chương trình vạn đại vẫn giữ nguyên.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
	    Kẻ sợ Chúa, Ngài hằng đoái nhìn,
	    kẻ trông cậy Chúa vẫn dủ thương,
	    Cứu thân họ khỏi sa tay tử thần,
	    Dưỡng nuôi họ ngày gặp bước khó khăn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Trọn hồn xác của đoàn con
	    này đợi trông Ngài cứu giúp chở che.
	    Hãy vui mừng vì nay luôn có Ngài.
	    Quyết tin cậy và thờ kính Thánh Danh.
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
  ragged-bottom = ##t
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2.5))
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
