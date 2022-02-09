% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Tán Dương Kỳ Công Chúa" }
  composer = "Tv. 67"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4 c8 c |
  a4. g8 |
  f f4 a8 |
  d,4 d16 (f) g8 |
  c,4. c16 (d) |
  c8 c'4 bf8 |
  a2 |
  a8 g4 c8 |
  f,2 |
  bf8 bf4 a8 |
  g2 ~ |
  g4 g8. a16 |
  g8 f d f16 (g) |
  c,4. c8 |
  c' bf a a ~ |
  a bf g c |
  f,2 \bar "||"
  
  f8. f16 g8 a ~ |
  a c d, \slashedGrace { \parenthesize d8 (} f) |
  g4 \slashedGrace { e16 ( } g8) e16 (d) |
  c4. c8 |
  f d4 f8 |
  g2 |
  bf8. bf16 g8 bf |
  c4. g8 |
  a a16 (g) f4 |
  d8. c16 f8 a ~ |
  a g c e, |
  f4 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  a8 a |
  f4. d8 |
  d d4 cs8 |
  d4 d8 [bf] |
  a4. a16 (bf) |
  a8 e'4 g8 |
  f2 |
  f8 e4 e8 |
  d2 |
  g8 g4 f8 |
  e2 ~ |
  e4 e8. f16 |
  c8 d b! [b] |
  c4. c8 |
  a' g f f ~ |
  f g e e |
  f2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Chúa đứng lên, địch thù Ngài tán loạn,
  kẻ ghét Ngài phải chạy trốn Thánh Nhan.
  Như làn khói cuộn, Chúa cuốn chúng đi.
  Như sáp tan gặp khi lửa hồng,
  kẻ dữ tiêu vong khi giáp mặt Chúa Trời.
  <<
    {
      \set stanza = "1."
      Còn người công chính múa nhảy
      \markup { \italic \underline mừng }
      vui trước nhan Ngài
      niềm hoan lạc trào dâng.
      Hãy hát mừng Thiên Chúa đàn ca Danh Ngài,
      Dọn đường cho Đấng ngự giá đằng vân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Nào cùng ca xướng hớn hở
	    \markup { \italic \underline mừng }
	    vui trước nhan Ngài,
	    Vị Chúa tể càn khôn,
	    Đấng dưỡng dục cô nhi, bênh đỡ góa phụ,
	    Đây Ngài ngự mãi trong thánh điện luôn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Tạo lập gia thất giúp kẻ đơn côi,
	    kẻ lưu tù được trả lại tự do.
	    Nhưng bao phường phản trắc toan tính ngỗ nghịch
	    Bị đẩy vô chốn hoang vắng cằn khô.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Vạn lạy Thiên Chúa lúc Ngài
	    \markup { \italic \underline hiển }
	    linh trước dân Ngài miền sa mạc hoang vu,
	    Đất đã từng chuyển rung, trời cao vỡ lở,
	    Nơi thần nhan Chúa, Thiên Chúa quyền linh.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Kìa đoàn dân Chúa mỏi mòn tiêu hao,
	    trút mưa nguồn Ngài tăng cường sinh khí.
	    Luôn bang trợ chở che ai sống khó nghèo,
	    Cho đoàn dân Chúa an thái lập cư.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
	    Ngài vừa tuyên sấm: xuất hiện thiên binh,
	    lãnh đám hầy cùng quân lực chạy trốn,
	    Ngay trên đỉnh San -- mon băng tuyết phủ đầy,
	    Khi Ngài xua đánh vua chúa trần gian.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Kìa Ngài thăng giá, dẫn đoàn
	    \markup { \italic \underline tù }
	    binh, lãnh đám người làm lễ vật dâng tiến,
	    Bao nhiêu phường phản phúc nay cũng tuốn về
	    Qui tụ nhau sống bên Chúa Trời luôn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "8."
	    Ngày ngày lên tiếng chúc tụng tôn vinh Chúa cứu độ
	    hằng bang trợ ta liên,
	    Nơi tay Ngài mở lối ta thoát tử thần,
	    Nhưng hằng truy quét bao lũ tội nhân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "9."
	    Vạn lạy Thiên Chúa, thế trần
	    \markup { \italic \underline từng }
	    coi đám rước Ngài hiển vinh vào đền thánh,
	    Bao ca đoàn mở lối theo tiếng nhã nhạc
	    Bên hàng nhi nữ khua trống rền vang.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "10."
	    Nào mọi vương quốc hãy hòa
	    \markup { \italic \underline lời }
	    ca tán dương Ngài là Chúa Trời cao sang,
	    Nghe đây Ngài lên tiếng,
	    lên tiếng dũng mạnh
	    Khi Ngài thăng giá ngự chốn cửu trùng.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 3))
  page-count = #2
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
