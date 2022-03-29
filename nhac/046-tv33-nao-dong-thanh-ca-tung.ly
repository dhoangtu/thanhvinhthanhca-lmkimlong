% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Nào Đồng Thanh Ca Tụng" }
  composer = "Tv. 33"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  f4. g16 (f) e8 (f) |
  a4. a8 g (a) |
  c2. |
  bf4 d g, |
  g4. e8 c' bf |
  a2. |
  a4. a8 f bf |
  bf2 bf8 (d) |
  g,2. |
  e4 d e |
  g4. c,8 f4 |
  f2 \bar "|" \break
  
  f8 f |
  bf4. g8 a bf |
  c2 d8 bf |
  c4. d8 bf a |
  g2 g8 d |
  d4. d8 d g |
  c,2 a'8 a |
  g4. e8 c' [bf] |
  a2 f8 f |
  bf4. g8 a bf |
  c2 d8 bf |
  c4. d8 bf a |
  g2 g8 d |
  d4. d8 d g |
  c,2 a'8 a |
  g4. c8 e, e |
  f2. \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  R2.*11
  r2
  f8 ef |
  d4. e8 f g |
  a2 bf8 g |
  a4. bf8 g f |
  c2 c8 c |
  bf4. bf8 bf b! |
  c2 f8 f |
  e4. c8 a c |
  f2 f8 ef |
  d4. e8 f g |
  a2 bf8 g |
  a4. bf8 g f |
  c2 c8 c |
  bf4. bf8 bf b! |
  c2 f8 f |
  e4. d8 c c |
  a2.
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Tôi chúc tụng Chúa trong mọi lúc,
      Câu hát mừng Người chẳng ngớt trên môi,
      Chúa đã làm cho tôi hãnh diện,
      Bạn nghèo nghe nói mà vui lên.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Đây kẻ nghèo khó kêu cầu Chúa
	    Người đã nhậm lời giải thoát cứu nguy,
	    Phái sứ thần vây quanh đóng trại,
	    Bang trợ ai kính sợ Tôn Danh.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Mau nếm thử Chúa êm dịu lắm,
	    Vinh phúc người nào tìm đến nương thân,
	    Hãy kính sợ uy danh của Ngài,
	    Không còn lo thiếu hụt khi nao.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Mau đến học biết tôn sợ Chúa,
	    Ta sẽ chỉ đường, này các con ơi,
	    Hết những người trông mong vĩnh tồn,
	    Mong đời hạnh phúc và an vui.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Luôn giữ miệng lưỡi xa điều ác,
	    Kiên quyết đừng học lời nói điêu ngoa,
	    Hãy kiếm tìm an vui thái bình,
	    Xa điều gian ác, chuộng công minh.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Bao kẻ tàn ác Chúa đả phá,
	    Trên cõi đời này biệt tích tiêu danh.
	    Mắt Chúa nhìn xem ai chính trực,
	    Luôn hằng nghe tiếng họ kêu van.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Khi kẻ lành đến kêu cầu Chúa,
	    Ngài giúp họ vượt mọi nỗi gian nan.
	    Chúa cứu độ ai đang thất vọng,
	    Ở gần ai cõi lòng tan hoang.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "8."
      \override Lyrics.LyricText.font-shape = #'italic
	    Bao kẻ lành mắc tai họa mãi,
	    Nhưng Chúa dủ tình hằng cứu nguy cho.
	    Chúa vẫn hằng quan tâm giữ gìn,
	    Xương họ bao chiếc còn y nguyên.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "9."
	    Quân ác sẽ chết do tội ác,
	    Kẻ ghét người lành tự chuốc nguy nan.
	    Chúa tế độ tôi trung của Ngài.
	    Nương mình bên Chúa họ an thân.
    }
  >>
  \set stanza = "ĐK:"
  Nào đồng thanh ngợi khen Thiên Chúa,
  hãy cùng tôi tán tụng danh Ngài.
  Tôi tìm Ngài và Ngài đáp lời,
  Cứu thoát tôi khỏi những lo âu,
  Nào đồng thanh tạ ơn Thiên Chúa,
  Hãy cùng tôi tán dương danh Ngài.
  Trông về Ngài lòng được vui mừng,
  không bao giờ bẽ mặt hổ ngươi.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2))
}

TongNhip = {
  \key f \major \time 3/4
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
    \override Lyrics.LyricSpace.minimum-distance = #1
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
