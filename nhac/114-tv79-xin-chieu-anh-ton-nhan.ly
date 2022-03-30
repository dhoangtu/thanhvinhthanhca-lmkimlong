% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Xin Chiếu Ánh Tôn Nhan" }
  composer = "Tv. 79"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \autoPageBreaksOff
  \partial 8 f8 |
  c c a' (bf16 a) |
  g4. g16 e |
  g8 f f d |
  c4. a16 c |
  f8 e g a |
  a2 |
  f8 bf g bf |
  c4. bf16 a |
  a8 e e a |
  d,4 d16 (f) d8 |
  c8 e g e |
  f4 r8 \bar "||" \break
  
  \pageBreak
  
  c8 |
  a'4 (bf8) a |
  g4. g8 |
  g8. a16 g8 e |
  f4. d8 |
  c4 r8 c16 c |
  c'8 c bf bf |
  c4. g16 bf |
  a8 e g c |
  f,2 ~ |
  f4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r8 |
  R2*11
  r4.
  c8 |
  f4 (g8) f |
  e4. e8 |
  e8. f16 c8 c |
  d4. b!8 |
  c4 r8 c16 c |
  a'8 a g g |
  a4. e16 g |
  f8 c bf bf |
  a2 ~ |
  a4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Xin phục hồi chúng con,
      Xin tỏa ánh Tôn Nhan rạng ngời
      Để đoàn con được ơn cứu rỗi.
      Lạy Chúa Tể càn khôn,
      Đến khi nao Ngài còn nổi giận,
      Chẳng nghe lời dân Chúa nguyện xin.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Châu lụy từng phút qua,
	    Chính Ngài bắt ăn thay lương thực,
	    Dòng lệ tuôn trào thay nước uống.
	    Ngài khiến thành duyên cớ
	    Để lân bang dành giật cãi cọ,
	    Lũ quân thù bêu diếu cười chê.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Đây thực là gốc nho
	    Tay Ngài bứng xưa bên Ai -- cập,
	    Dẹp chư dân, trồng vô đất chúng.
	    Dọn tứ bề quang đãng,
	    Rễ ăn sâu, phủ rợp khắp miền,
	    Nhánh vươn dài ra tới đại dương.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Xin trở lại Chúa ơi,
	    Xin từ cõi cao xanh thương nhìn,
	    Trở lại thăm vườn nho cũ đó
	    Nguyện bảo vệ chăm sóc
	    Chính cây tay Ngài trồng thuở nào,
	    Khiến cho chồi non lớn mạnh lên.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Nay được Ngài đoái thương,
	    Đoan nguyện sẽ luôn luôn trung thành,
	    Trọn đời không lìa xa Chúa nữa,
	    Nhờ ơn Ngài cho sống,
	    Chúng con xin ngàn đời tán tụng,
	    Thánh Danh Ngài muôn kiếp truyền rao.
    }
  >>
  \set stanza = "ĐK:"
  Lạy Chúa thiên binh,
  xin cho chúng con trùng hưng khôi phục,
  Và dọi chiếu ánh tôn nhan Chúa
  Để chúng con được ơn Cứu Độ.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2))
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
