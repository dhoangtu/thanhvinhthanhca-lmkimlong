% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Muôn Câu Cảm Tạ" }
  composer = "Tv. 117"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \autoPageBreaksOff
  \partial 8 f16 g |
  a4 \tuplet 3/2 { e8 e f } |
  d4. d16 c |
  g'8 g e e |
  f4 r8 bf16 bf |
  bf8 a d
  \afterGrace bf8 ({
    \override Flag.stroke-style = #"grace"
    a16)}
  \revert Flag.stroke-style
  g4 \tuplet 3/2 { g8 c bf } |
  a4 r8 a16 a |
  g8 g c
  \afterGrace a8 ({
    \override Flag.stroke-style = #"grace"
    g16)}
  \revert Flag.stroke-style
  
  \pageBreak
  
  f4 \tuplet 3/2 { e8 g f } |
  c4 r8 c |
  g'8 g16 f a8 g16 g |
  bf4 r8 d,16 c |
  g'8 g e e |
  f4 r8 \bar "||" \break
  
  f16 f |
  e8 f f e |
  c4. c8 |
  a'8. a16 bf (a) f8 |
  g4 r8 bf16 bf |
  bf8 g c bf |
  a4. a8 |
  g8. bf16 a8 g |
  f4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r8 |
  R2*13
  r4.
  f16 f |
  e8 f f e |
  c4. c8 |
  f8. f16 g (f) d8 |
  c4 r8 g'16 g |
  g8 f e g |
  f4. f8 |
  e8. d16 c8 bf |
  a4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Tạ ơn Chúa vì Ngài nhân từ,
      Ân tình Chúa vững bền ngàn thu
      Ít -- ra -- en hãy nói lên rằng:
      Tình Chúa thiên thu,
      A -- ha -- ron hãy nói lên rằng:
      Tình Chúa muôn đời,
      Và ai tôn sợ Chúa nào hãy nói:
      Ân tình Chúa vững bền ngàn thu.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Cầu xin Chúa vào hồi cơ cùng,
	    Đây Ngài đáp tiếng và giải nguy.
	    Tôi nay đâu sợ hãi ai nào,
	    Vì Chúa bên tôi,
	    Tôi hiên ngang nhìn lũ quân thù,
	    Vì Chúa độ trì,
	    Tìm trông bên cạnh Chúa mà ẩn náu
	    Hơn là nấp bóng người trần gian.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Nhờ danh Chúa trừ diệt quân thù
	    Khi họ xấn tới dàn vòng vây,
	    Đông như ong bủa kín tư bề,
	    Rực nóng như thiêu,
	    Vây quanh tôi chèn lấn mưu đồ
	    Quật ngã thân này,
	    Nhờ uy danh của Chúa hằng trợ giúp,
	    Tôi mạnh mẽ tiễu trừ họ luôn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Hồn tôi vẫn hằng tụng ca Ngài,
	    Ơn giải thoát, sức mạnh của tôi,
	    Nghe reo vang toàn thắng trong trại
	    Của những chính nhân,
	    Bao uy phong ở cánh tay Ngài thần thánh cao cường,
	    Và tôi không phải chết mà sẽ sống
	    Để truyền bá vĩ nghiệp Ngài luôn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Cửa công chính mở để tôi vào
	    Ca mừng Chúa với lời tạ ơn
	    Nguy nga thay cửa dẫn đưa vào
	    Đền thánh Chúa đây,
	    Ai luôn theo đường lối chính trực,
	    Cùng tiến lên nào.
	    Này con xin thành kính cảm tạ Chúa
	    Bởi Ngài đáp tiếng độ trì con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Này viên đá bị thợ xây loại
	    Nay thành đá góc tường rồi đây.
	    Ôi bao công trình Chúa đã làm
	    Thực lớn lao thay,
	    Mau vui ca mừng hát trong ngày
	    Ngài đã tạo thành,
	    Nhờ bao ân lộc Chúa được thịnh phát,
	    Ân lộc Chúa cứu độ đoàn con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Người đang đến nhân danh của Ngài,
	    Xin Ngài xuống phúc lành đầy dư,
	    Tay mang theo ngành lá lên gần
	    Bàn thánh Chúa đây,
	    Nơi cung ngai Thượng Đế ta thờ,
	    Dọi sáng huy hoàng,
	    Nào mau cảm tạ Chúa đầy từ ái,
	    Ân tình Chúa vững bền ngàn thu.
    }
  >>
  \set stanza = "ĐK:"
  Xin dâng lên muôn câu cảm tạ,
  lạy Chúa, Thiên Chúa của con,
  Xin dâng lên vạn tiếng tôn vinh,
  Muôn lạy Đấng con tôn thờ.
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
